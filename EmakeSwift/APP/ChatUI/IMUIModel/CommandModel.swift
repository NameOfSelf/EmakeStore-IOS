//
//  CommandModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/8/30.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper

enum CommandType: String {
    case UserRequestService = "UserRequestService"
    case RequestSwitchService = "RequestSwitchService"
    case StoreRequestService = "StoreRequestService"
    case UserMessageList = "UserMessageList"
    case MessageList = "MessageList"
    case StoreCustomerList = "StoreCustomerList" //
    case StoreServiceUserList = "StoreServiceUserList" //
    case ChatroomCustomerList = "ChatroomCustomerList" //
    case CustomerAcceptService = "CustomerAcceptService" //
    case CustomerClosedService = "CustomerClosedService" //
}

class CommandModel: Mappable {
    
    var cmd : String?
    var user_id : String?
    var message_id_last : NSInteger?
    var customer_id : String?
    var customer_ids : [String]?
    var message_last : String?
    var user_info : String?
    var chatroom_id : String?
    
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cmd <- map["cmd"]
        user_id <- map["user_id"]
        message_id_last <- map["message_id_last"]
        customer_id <- map["customer_id"]
        customer_ids <- map["customer_ids"]
        message_last <- map["message_last"]
        user_info <- map["user_info"]
        chatroom_id <- map["chatroom_id"]
    }
    //请求聊天记录
    class func creatCustomerLisCMD(userId:String,mesageId:NSInteger) -> [String:Any]{
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let commmadModel = CommandModel()
        commmadModel.cmd = "MessageList"
        commmadModel.user_id = userId
        commmadModel.message_id_last = mesageId
        commmadModel.customer_id = ""
        commmadModel.chatroom_id = String(format: "%@/%@", arguments: [storeId,userId])
        commmadModel.user_info = ""
        let json = commmadModel.toJSON()
        return json
    }
    //转接客服列表获取
    class func creatStoreCustomerLisCMD() -> [String:Any]{
        let commmadModel = CommandModel()
        commmadModel.cmd = "StoreCustomerList"
        commmadModel.user_id = ""
        commmadModel.message_id_last = 0
        commmadModel.customer_id = ""
        commmadModel.user_info = ""
        commmadModel.chatroom_id = ""
        let json = commmadModel.toJSON()
        return json
    }
    //客服转接
    class func creatRequestSwitchServiceCMD(userId:String,switchServerId:String,userInfo:String) -> [String:Any]{
        let commmadModel = CommandModel()
        commmadModel.cmd = "RequestSwitchService"
        commmadModel.user_id = userId;
        commmadModel.message_id_last = 0
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        commmadModel.customer_id = String(format: "customer/%@/%@", arguments: [storeId,switchServerId])
        commmadModel.chatroom_id = String(format: "%@/%@", arguments: [storeId,userId])
        commmadModel.user_info = userInfo
        let json = commmadModel.toJSON()
        return json
    }
    
    class func creatChatroomCustomerListCMD() -> [String:Any]{
        let commmadModel = CommandModel()
        commmadModel.cmd = "ChatroomCustomerList"
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let MQTT_ServerChatRoomID = String(format: "%@/%@", arguments: [storeId,serverId])
        commmadModel.chatroom_id = MQTT_ServerChatRoomID
        commmadModel.user_id = ""
        commmadModel.message_id_last = 0
        commmadModel.user_info = ""
        commmadModel.customer_id = ""
        let json = commmadModel.toJSON()
        return json
    }
    
    class func creatRequestServiceCMD() -> [String:Any]{
        let commmadModel = CommandModel()
        commmadModel.cmd = "RequestService"
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let MQTT_ServerChatRoomID = String(format: "%@/%@", arguments: [storeId,serverId])
        commmadModel.chatroom_id = MQTT_ServerChatRoomID
        commmadModel.user_id = serverId
        commmadModel.message_id_last = 0
        
        let UserDefalultStoreName = UserDefaults.standard.object(forKey: EmakeStoreName)
        let UserDefalultStorePhoto = UserDefaults.standard.object(forKey: EmakeStorePhoto)
        let grop = ["GroupName":UserDefalultStoreName ?? "","GroupPhoto":UserDefalultStorePhoto ?? ""]
        let gropModel = Mapper<GroupModel>().map(JSON: grop)
        let gropString = gropModel?.toJSONString(prettyPrint: true)
        let userId = UserDefaults.standard.object(forKey: EmakeUserId) as! String
        let userinfo = MessageFromModel()
        userinfo.Avatar = ""
        userinfo.DisplayName = serverId
        if (UserDefaults.standard.object(forKey: EmakeUserPhoneNumber) != nil) {
            userinfo.PhoneNumber = UserDefaults.standard.object(forKey: EmakeUserPhoneNumber) as? String
        }else{
            userinfo.PhoneNumber = ""
        }
        if (UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) != nil) {
            userinfo.Avatar = UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) as? String
        }else{
            userinfo.Avatar = ""
        }
        let MQTTClienID = String(format: "customer/%@/%@", arguments: [storeId,serverId])
        userinfo.ClientID = MQTTClienID
        userinfo.UserType = ""
        userinfo.UserId = userId
        userinfo.Group = gropString
        var userinfoArray : [[String:Any]] = []
        userinfoArray.append(userinfo.toJSON())
        let data = try? JSONSerialization.data(withJSONObject: userinfoArray, options: .prettyPrinted)
        let jsonStr = String(data: data!, encoding: String.Encoding.utf8)
        commmadModel.user_info = jsonStr
        commmadModel.customer_id = ""
        let json = commmadModel.toJSON()
        return json
    }
    
    class func creatStoreServiceUserList() -> [String:Any] {
        let commmadModel = CommandModel()
        commmadModel.cmd = "StoreServiceUserList"
        commmadModel.user_id = ""
        commmadModel.message_id_last = 0
        commmadModel.user_info = ""
        commmadModel.customer_id = ""
        commmadModel.chatroom_id = ""
        let json = commmadModel.toJSON()
        return json
    }
    
    class func creatCustomerAcceptService(userId:String) -> [String:Any] {
        let commmadModel = CommandModel()
        commmadModel.cmd = "CustomerAcceptService"
        commmadModel.user_id = userId
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        commmadModel.chatroom_id = String(format: "%@/%@", arguments: [storeId,userId])
        commmadModel.customer_id = serverId
        commmadModel.message_id_last = 0
        commmadModel.user_info = ""
        let json = commmadModel.toJSON()
        return json
    }
    
}
