//
//  RealmChatTool.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RealmSwift

class RealmChatTool: Object {

    private class func getChatListDB() -> Realm {
        
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let fileName = String(format: "/ChatList_%@.realm", arguments: [serverId])
        let dbPath = docPath.appending(fileName)
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
    
    private class func getChatDataDB() -> Realm {
        
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/ChatDataDB.realm")
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}
extension RealmChatTool {
    
    public class func insertChatListData(by message : RealmChatListData) {
        let defaultRealm = self.getChatListDB()
        try! defaultRealm.write {
            defaultRealm.add(message, update: true)
        }
    }

    public class func insertChatData(by message : RealmChatData) {
        
        let defaultRealm = self.getChatDataDB()
        try! defaultRealm.write {
            defaultRealm.add(message, update: true)
        }
    }

    public class func getAllChatListData() -> Results<RealmChatListData> {
        
        let defaultRealm = self.getChatListDB()
        return defaultRealm.objects(RealmChatListData.self)
    }
    
    //主键查询
    public class func getOneChatListData(with clientId:String) -> RealmChatListData {
        
        let defaultRealm = self.getChatListDB()
        return defaultRealm.object(ofType: RealmChatListData.self, forPrimaryKey: clientId)!
    }
    
    //列表删除
    public class func deleteChatListData(with clientId:String){
        let chatOneList = self.getOneChatListData(with: clientId)
        let defaultRealm = self.getChatListDB()
        try! defaultRealm.write {
            defaultRealm.delete(chatOneList)
        }
    }
    
    public class func updateChatListCount(with message:RealmChatListData){
        let defaultRealm = self.getChatListDB()
        try! defaultRealm.write {
            defaultRealm.add(message, update: true)
        }
    }
    
    public class func getChatList(clientId : String) -> RealmChatListData?{
        
        let defaultRealm = self.getChatListDB()
        return defaultRealm.object(ofType: RealmChatListData.self, forPrimaryKey: clientId)
    }
    
    public class func isMessageHaveAll(page:NSInteger,lastMessageId:NSInteger,chatRoomId:String) -> Bool {
        let defaultRealm = self.getChatDataDB()
        let chatDatas = defaultRealm.objects(RealmChatData.self).filter("chatRoomID = %@", chatRoomId)
        var messageIdArray : [String]? = []
        for data in chatDatas {
            messageIdArray?.append(data.messageID!)
        }
        if lastMessageId <= 0{
            return false
        }else if lastMessageId < 10{
            for i in 0..<lastMessageId{
                let messageId = lastMessageId - 10*(page-1) - i
                let messageIDString = String(format: "%ld", arguments: [messageId])
                if !(messageIdArray?.contains(messageIDString))! {
                    return false
                }
            }
        }else{
            if (lastMessageId-(page-1)*10) < 0{
                return false
            }else if (lastMessageId-(page-1)*10) < 10 {
                for i in 0..<(lastMessageId - (page-1)*10){
                    let messageId = lastMessageId - 10*(page-1) - i
                    let messageIDString = String(format: "%ld", arguments: [messageId])
                    if !(messageIdArray?.contains(messageIDString))! {
                        return false
                    }
                }
            }else{
                for i in 0..<10 {
                    let messageId = lastMessageId - 10*(page-1) - i
                    let messageIDString = String(format: "%ld", arguments: [messageId])
                    if !(messageIdArray?.contains(messageIDString))! {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    public class func getMessageDataWithPage(page:NSInteger,lastMessageId:NSInteger,chatRoomId:String,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock){
        var messageIdArray : [String]? = []
        for i in 0..<10 {
            let messagId = lastMessageId - 10*(page-1)-i;
            let messageIDString = String(format: "%d", arguments: [messagId])
            messageIdArray?.append(messageIDString)
        }
        let defaultRealm = self.getChatDataDB()
        let chatDatas = defaultRealm.objects(RealmChatData.self).filter("chatRoomID = %@", chatRoomId)
        var filterData : [RealmChatData]? = []
        for data in chatDatas {
            if (messageIdArray?.contains(data.messageID!))!{
                filterData?.append(data)
            }
        }
        if chatDatas.count <= 0 {
            failedBlock("暂无消息")
        }else{
            successBlock(filterData)
        }
    }
    
    
    public class func getMessageDataMaxMessageID(chatRoomId:String) -> NSInteger {
        
        var maxMessageID = 0
        let defaultRealm = self.getChatDataDB()
        let chatDatas = defaultRealm.objects(RealmChatData.self).filter("chatRoomID = %@", chatRoomId)
        for data in chatDatas {
            let number = Int(data.messageID!)
            if number! > maxMessageID {
                maxMessageID = number!
            }
        }
        return maxMessageID
    }
}
