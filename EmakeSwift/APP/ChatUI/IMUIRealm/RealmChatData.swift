//
//  RealmChatData.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RealmSwift
class RealmChatListData: Object {
    
    @objc dynamic var userName : String?
    @objc dynamic var userAvata : String?
    @objc dynamic var userPhone : String?
    @objc dynamic var userType : String?
    @objc dynamic var sendTime : String?
    @objc dynamic var clientId : String?
    @objc dynamic var message : String?
    @objc dynamic var messageType : String?
    @objc dynamic var messageCount : String?
    @objc dynamic var groupInfo : String?
    @objc dynamic var chatRoomID : String?
    override class func primaryKey() -> String? {
        return "clientId"
    }
}
class RealmChatData: Object {
    
    @objc dynamic var userName : String?
    @objc dynamic var userAvata : String?
    @objc dynamic var userPhone : String?
    @objc dynamic var userType : String?
    @objc dynamic var sendTime : String?
    @objc dynamic var clientId : String?
    @objc dynamic var message : String?
    @objc dynamic var messageType : String?
    @objc dynamic var messageIdString : String?
    @objc dynamic var messageID : String?
    @objc dynamic var groupInfo : String?
    @objc dynamic var chatRoomID : String?
    
    override class func primaryKey() -> String? {
        return "messageIdString"
    }
}
