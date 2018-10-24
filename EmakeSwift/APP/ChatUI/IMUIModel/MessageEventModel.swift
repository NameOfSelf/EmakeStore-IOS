//
//  MessageEventModel.swift
//  sample
//
//  Created by oshumini on 2017/6/16.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation

class MessageEventModel: NSObject, IMUIMessageProtocol {
    var messageID: Int = 0
    var msgId: String = ""
    var eventText: String = ""
    var sendTime: String = ""
    init(msgId: String,messageId:Int, eventText: String, sendTime: String) {
        super.init()
        self.msgId = msgId
        self.messageID = messageId
        self.eventText = eventText
        self.sendTime = sendTime
  }
}

class MessageEventTipsModel: NSObject, IMUIMessageProtocol {
    var messageID: Int = 0
    var msgId: String = ""
    var eventText: String = ""
    var sendTime: String = ""
    init(msgId: String,messageId:Int, eventText: String, sendTime: String) {
        super.init()
        self.msgId = msgId
        self.messageID = messageId
        self.eventText = eventText
        self.sendTime = sendTime
    }
}

class MessageSuperGroupModel: NSObject, IMUIMessageProtocol {
    var messageID: Int = 0
    var msgId: String = ""
    var eventText: String = ""
    var sendTime: String = ""
    init(msgId: String,messageId:Int, eventText: String, sendTime: String) {
        super.init()
        self.msgId = msgId
        self.messageID = messageId
        self.eventText = eventText
        self.sendTime = sendTime
    }
}
