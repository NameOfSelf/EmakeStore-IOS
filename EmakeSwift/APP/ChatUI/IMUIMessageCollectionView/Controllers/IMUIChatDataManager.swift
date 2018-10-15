//
//  IMUIChatDataManager.swift
//  IMUIChat
//
//  Created by oshumini on 2017/2/27.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit

var needShowTimeInterval = Double.greatestFiniteMagnitude


class IMUIChatDataManager: NSObject {
  var allMsgidArr = [String]()
  var allMessageDic = [String:IMUIMessageProtocol]()
  var allOrderIdArr = [String:Int]()
  var count: Int {
    return allMsgidArr.count
  }
  
  subscript(index: Int) -> IMUIMessageProtocol {
    let msgId = allMsgidArr[index]
    return allMessageDic[msgId]!
  }
  
  subscript(msgId: String) -> IMUIMessageProtocol? {
    return allMessageDic[msgId]
  }
  
  var endIndex: Int {
    return allMsgidArr.endIndex
  }
  
  func cleanCache() {
    allMsgidArr.removeAll()
    allMessageDic.removeAll()
    allOrderIdArr.removeAll()
  }
  
  func index(of message: IMUIMessageProtocol) -> Int? {
    return allMsgidArr.index(of: message.msgId)
  }
  
  @objc open func appendMessage(with message: IMUIMessageProtocol) {
    
    self.allMsgidArr.append(message.msgId)
    self.allMessageDic[message.msgId] = message
    self.allOrderIdArr[message.msgId] = message.messageID
  }
    open func addMessage(with message: IMUIMessageProtocol) {
        var messageID : [Int]? = []
        let insertMessageId = message.messageID
        for i in 0..<allMessageDic.count {
            let messageId = allMsgidArr[i]
            let messageModel = allMessageDic[messageId]
            messageID?.append(messageModel!.messageID)
        }
        if (messageID?.count)! <= 0 {
            self.appendMessage(with: message)
            return
        }
        if insertMessageId <= (messageID?.first)!{
            self.allMsgidArr.insert(message.msgId, at: 0)
            self.allMessageDic[message.msgId] = message
            self.allOrderIdArr[message.msgId] = message.messageID
            return
        }
        if insertMessageId >= (messageID?.last)!{
            self.appendMessage(with: message)
            return
        }
        if (messageID?.count)! >= 2{
            for i in 0..<((messageID?.count)!-1) {
                if (insertMessageId >= messageID![i]) && (insertMessageId
                    < messageID![i+1]) {
                    self.allMsgidArr.insert(message.msgId , at: i+1)
                    self.allMessageDic[message.msgId] = message
                    self.allOrderIdArr[message.msgId] = message.messageID
                }
            }
        }
    }
    
  func updateMessage(with message: IMUIMessageProtocol) {
    if message.msgId == "" {
      print("the msgId is empty, cann't update message")
      return
    }
    
    allMessageDic[message.msgId] = message
    allOrderIdArr[message.msgId] = message.messageID
  }
  
  func removeMessage(with messageId: String) {
    if messageId == "" {
      print("the msgId is empty, cann't update message")
      return
    }
    allMessageDic.removeValue(forKey: messageId)
    allOrderIdArr.removeValue(forKey: messageId)
    if let index = allMsgidArr.index(of: messageId) {
      allMsgidArr.remove(at: index)
    }
  }
  
  func removeAllMessages() {
    allMessageDic.removeAll()
    allOrderIdArr.removeAll()
    allMsgidArr.removeAll()
  }
  
  func insertMessage(with message: IMUIMessageProtocol) {
    if message.msgId == "" {
      print("the msgId is empty, cann't insert message")
      return
    }
    self.allMsgidArr.insert(message.msgId, at: 0)
    self.allMessageDic[message.msgId] = message
    self.allOrderIdArr[message.msgId] = message.messageID
  }
  
  open func insertMessages(with messages:[IMUIMessageProtocol]) {
    for element in messages {
      self.insertMessage(with: element)
    }
  }
}
