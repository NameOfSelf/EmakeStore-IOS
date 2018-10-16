//
//  MQTTClientDefault.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/8/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import MQTTClient
import ObjectMapper
import RealmSwift
enum MessageType:String {
    case message = "Message"
    case event
}
class MQTTClientDefault: NSObject {
    
    static let client : MQTTClientDefault = MQTTClientDefault()
    var transport : MQTTCFSocketTransport?
    var session : MQTTSession?
    var connectCount : NSInteger?
    weak var delegate : MQTTClientDefaultDelegate?
    var nowCount : NSInteger?
    let isAutoConnect = true
    //单例 初始化
    class func shared() -> MQTTClientDefault {
        return self.client
    }
    public class func initMQTT() {
        
        self.client.transport?.host = MQTT_IP
        self.client.transport?.port = UInt32(MQTT_PORT)
        self.client.session = MQTTSession()
        self.client.session?.transport = MQTTClientDefault.client.transport
        self.client.session?.keepAliveInterval = 60
        self.client.session?.protocolLevel = .version311
        self.client.session?.cleanSessionFlag = false
        self.client.session?.delegate =  self.client
        self.client.connectCount = 1000
        self.client.nowCount = 0
    }
    //连接
    public func connectToHost(withServerId:String,storeID:String){
        let CMDTopic = "customer/" + storeID + "/" + withServerId
        let ServerTopic = "chatroom/" + storeID + "/" + withServerId
        self.session?.clientId = CMDTopic
        self.session?.connect(toHost: MQTT_IP, port: UInt32(MQTT_PORT), usingSSL: false, connectHandler: { (error) in
            if error == nil{
                //订阅MQTT_CMDTopic
                self.subcribeTo(topic: CMDTopic)
                //订阅MQTT_ServerTopic
                self.subcribeTo(topic: ServerTopic)
            }
        })
    }
    
    //订阅
    public func subcribeTo(topic:String){
        self.session?.subscribe(toTopic: topic, at:.exactlyOnce, subscribeHandler: { (error, Qos) in
            if error == nil{
                print("订阅成功")
            }else{
                print("订阅失败")
            }
        })
    }
    
    //取消订阅
    public func unSubcribeTo(topic:String){
        self.session?.unsubscribeTopic(topic, unsubscribeHandler: { (error) in
            if error == nil{
                print("取消订阅成功")
            }else{
                print("取消订阅失败")
            }
        })
    }
    
    //发送消息
    public func sendMessage(withMessage:Dictionary<String, Any>?,topic:String,completeBlock:@escaping (Any)->()){
        let data = try! JSONSerialization.data(withJSONObject:withMessage!, options: .prettyPrinted)
        self.session?.publishData(data, onTopic: topic, retain: false, qos: .exactlyOnce, publishHandler: { (error) in
            if error == nil {
                completeBlock("success")
            }else{
                
            }
        })
    }
    
    //断开连接
    public func disConnect(){
        self.session?.disconnect()
    }
}
    
extension MQTTClientDefault: MQTTSessionDelegate{
    
    //消息接收
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
        
        let payload = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! Dictionary<String, Any>
        print("消息------\(payload)")
        
        if (payload["MessageType"] != nil) {//普通消息
            let messageModel = Mapper<MessageModel>().map(JSONObject: payload)
            //2.消息弹框推送（前台/后台）
            
            self.pushNotice(model:messageModel!)
            
            //3.聊天存储
            //聊天数据
            let chatData = RealmChatData()
            let messageBodyText = messageModel?.MessageBody?.toJSONString(prettyPrint: true)
            chatData.chatRoomID = topic
            chatData.userName = messageModel?.From?.DisplayName ?? ""
            chatData.userAvata = messageModel?.From?.Avatar ?? ""
            chatData.userPhone = messageModel?.From?.PhoneNumber ?? ""
            chatData.clientId = messageModel?.From?.ClientID ?? ""
            chatData.message =  messageBodyText ?? ""
            chatData.messageID = String(format: "%d", arguments: [(messageModel?.MessageID)!])
            chatData.messageIdString = messageModel?.MessageId
            chatData.sendTime = String(format: "%d", arguments: [(messageModel?.Timestamp)!])
            chatData.userType = messageModel?.From?.UserType
            chatData.groupInfo = messageModel?.From?.Group
            chatData.messageType = messageModel?.MessageBody?.Type
            chatData.userType = messageModel?.From?.UserType ?? ""
            RealmChatTool.insertChatData(by: chatData)
        
            //聊天列表
            let chatList = RealmChatListData()
            chatList.chatRoomID = topic
            let part = topic.components(separatedBy: "/")
            var clientId = ""
            if part.count == 3 {
                clientId = "user/" + part[2]
            }
            
            let listData = RealmChatTool.getChatList(clientId: clientId)
            if (messageModel?.From?.ClientID?.contains("user/"))! {
                chatList.userName = messageModel?.From?.DisplayName ?? ""
                chatList.userAvata = messageModel?.From?.Avatar ?? ""
                chatList.userPhone = messageModel?.From?.PhoneNumber ?? ""
                chatList.userType = messageModel?.From?.UserType
            }else{
                if listData != nil {
                    chatList.userName = listData?.userName
                    chatList.userAvata = listData?.userAvata
                    chatList.userPhone = listData?.userPhone
                    chatList.userType = listData?.userType
                }
            }
            print(listData?.messageCount)
            let count = Int(listData?.messageCount ?? "0")! + 1
            print(String(format: "%d", arguments: [count]))
            chatList.messageCount = String(format: "%d", arguments: [count])
            chatList.clientId = clientId
            chatList.message =  messageBodyText ?? ""
            chatList.sendTime = String(format: "%d", arguments: [(messageModel?.Timestamp)!])
            chatList.groupInfo = messageModel?.From?.Group ?? ""
            chatList.messageType = messageModel?.MessageBody?.Type
            RealmChatTool.insertChatListData(by: chatList)
            //4.列表刷新
            if Tools.getCurrentViewController().isKind(of: STMessageListViewController.self) {
                let messageListVC = Tools.getCurrentViewController() as! STMessageListViewController
                messageListVC.messageList = RealmChatTool.getAllChatListData()
                messageListVC.table?.reloadSections([1], with: .none)
            }
            
            //1.消息回调
            if messageModel?.MessageType == MessageType.message.rawValue{
                self.delegate?.messageReceived(messageModel: messageModel!, topic: topic)
            }
            
            
        }else{//指令消息
            //1.消息回调
            let commandModel = Mapper<CommandModel>().map(JSONObject: payload)
            if commandModel?.cmd == CommandType.UserRequestService.rawValue || commandModel?.cmd == CommandType.RequestSwitchService.rawValue{
                
                let message = self.creatMessageModel(model:commandModel!)
                self.refreshMessageList(with: message)
                
            }else if commandModel?.cmd == CommandType.ChatroomCustomerList.rawValue{
                let list = commandModel?.customer_ids
                UserDefaults.standard.setValue(list, forKey: EmakeServerList)
            }else if commandModel?.cmd == CommandType.StoreServiceUserList.rawValue{
                if payload["chatroom_ids"] == nil {
                    return
                }
                let customer_ids = payload["chatroom_ids"] as! [String]
                for jsonStr in customer_ids {
                    let requst = Mapper<CommandModel>().map(JSONString: jsonStr)
                    let message = self.creatMessageModel(model: requst!)
                    self.refreshMessageList(with: message)
                }
                
            }
            
            self.delegate?.commandReceived(commandModel: commandModel!, topic: topic)
        }
    }
    
    func pushNotice(model:MessageModel)  {
        
        let state = UIApplication.shared.applicationState
        if state != UIApplicationState.background {
            return
        }
        if model.MessageBody?.Type == MessageBodyType.Text.rawValue{
            JZUserNotification.shared().add(withCategroy1: model.MessageBody?.Text)
        }else if model.MessageBody?.Type == MessageBodyType.Image.rawValue{
            JZUserNotification.shared().add(withCategroy1: "[图片]")
        }else if model.MessageBody?.Type == MessageBodyType.Voice.rawValue{
            JZUserNotification.shared().add(withCategroy1: "[语音]")
        }else if model.MessageBody?.Type == MessageBodyType.MutilePart.rawValue{
            JZUserNotification.shared().add(withCategroy1: "[合同]")
        }else if model.MessageBody?.Type == MessageBodyType.Goods.rawValue{
            JZUserNotification.shared().add(withCategroy1: "[商品]")
        }else if model.MessageBody?.Type == MessageBodyType.File.rawValue{
            JZUserNotification.shared().add(withCategroy1: "[文件]")
        }else if model.MessageBody?.Type == MessageBodyType.Order.rawValue{
            JZUserNotification.shared().add(withCategroy1: "[订单]")
        }
    }
    
    
    func creatMessageModel(model:CommandModel) -> MessageModel{
        
        let message = MessageModel()
        message.From = MessageFromModel()
        message.MessageBody = MessageBodyModel()
        let data = model.user_info?.data(using: .utf8)
        do {
            let jsonObj:[[String:Any]] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:Any]]
            let userInfoList = Mapper<MessageFromModel>().mapArray(JSONArray: jsonObj)
            if userInfoList.count > 0 {
                let from = userInfoList[0]
                message.From?.Avatar = from.Avatar
                message.From?.DisplayName = from.DisplayName
                message.From?.UserType = from.UserType
                message.From?.ClientID = from.ClientID
                message.From?.PhoneNumber = from.PhoneNumber
                message.From?.UserId = from.UserId
                message.From?.Group = from.Group
                let messageLast = Mapper<MessageModel>().map(JSONString: model.message_last ?? "")
                message.Timestamp  = messageLast?.Timestamp
                message.MessageBody?.Text  = messageLast?.MessageBody?.Text
                message.MessageBody?.Type = messageLast?.MessageBody?.Type
                if model.cmd == CommandType.UserRequestService.rawValue{
                    message.isSwitchMessage = false
                }else{
                    let partArray = model.customer_id?.components(separatedBy: "/")
                    if partArray?.count == 3 {
                        message.isSwitchMessage = true
                        message.switchServerID = partArray?[2]
                    }
                }
                
            }
        }catch {
            
        }
        return message
    }
    //刷新
    func refreshMessageList(with message:MessageModel) {
        let window = UIApplication.shared.keyWindow
        let currentVC = window?.rootViewController
        let tabBarVC = currentVC as! BaseTabBarController
        let navc =  tabBarVC.viewControllers[0] as! BaseNavigationViewController
        var clientIdArray : [String] = []
        for vc in navc.viewControllers {
            if vc.isKind(of: STMessageListViewController.self) {
                let messageListVC = vc as! STMessageListViewController
                var responseArray : [MessageModel] = NSMutableArray(array: messageListVC.responseList!) as! [MessageModel]
                for messageOne in responseArray {
                    clientIdArray.append((messageOne.From?.ClientID)!)
                }
                if clientIdArray.count <= 0 {
                    responseArray.insert(message, at: 0)
                }else{
                    if clientIdArray.contains((message.From?.ClientID)!) {
                        let index = clientIdArray.index(of: (message.From?.ClientID)!)
                        responseArray.remove(at: index!)
                        responseArray.insert(message, at: 0)
                    }else{
                        responseArray.insert(message, at: 0)
                    }
                }
                messageListVC.responseList = responseArray
                messageListVC.table?.reloadSections([0], with: .none)
            }
        }
    }
    
    
    func protocolError(_ session: MQTTSession!, error: Error!) {
        print("消息错误")
    }
    
    func handleEvent(_ session: MQTTSession!, event eventCode: MQTTSessionEvent, error: Error!) {
        
        switch eventCode {
        case .connected:
            print("MQTT连接状态----connected")
        case .connectionClosed:
            print("MQTT连接状态----connection closed")
        case .connectionRefused:
            print("MQTT连接状态----connection error")
        default:
            print("MQTT连接状态----connection refused")
            self.autoConnnect()
        }
    }
    
    //自动重连（一秒）
    private func autoConnnect() {
        if self.isAutoConnect {
            if self.nowCount! <= self.connectCount!{
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    if UserDefaults.standard.object(forKey: EmakeUserId) != nil{
                        let serverID = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
                        let storeID = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
                        self.connectToHost(withServerId: serverID, storeID: storeID)
                    }
                }
            }
        }
    }
}

protocol MQTTClientDefaultDelegate : NSObjectProtocol{
    
    func messageReceived(messageModel:MessageModel,topic:String)
    
    func commandReceived(commandModel:CommandModel,topic:String)
    
}

