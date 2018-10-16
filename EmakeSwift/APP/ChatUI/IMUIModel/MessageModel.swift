//
//  MessageModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/8/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
//消息体
class MessageModel: Mappable {
    var ToId : String?
    var From : MessageFromModel?
    var MessageBody : MessageBodyModel?
    var isOutGoing : String?
    var MessageID : Int?
    var MessageId : String?
    var MessageType : String?
    var Timestamp : Int?
    var isSwitchMessage : Bool?
    var switchServerID : String?
    var isDisplayMessage : Bool?
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        ToId <- map["ToId"]
        From <- map["From"]
        MessageBody <- map["MessageBody"]
        isOutGoing <- map["isOutGoing"]
        MessageID <- map["MessageID"]
        MessageId <- map["MessageId"]
        MessageType <- map["MessageType"]
        Timestamp <- map["Timestamp"]
    }
    
    
}
class MessageBodyModel: Mappable {
    var `Type` : String?//加引号区别关键字
    var Text : String?
    var Image : String?
    var Voice : String?
    var VoiceDuration : Int?
    var Url : String?
    var ImageUrl : String?
    var Contract : String?
    var ContractType : String?
    var ContractState : String?
    var IsIncludeTax : String?
    required init?(map: Map) {
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        `Type` <- map["Type"]
        Text <- map["Text"]
        Image <- map["Image"]
        Voice <- map["Voice"]
        VoiceDuration <- map["VoiceDuration"]
        Url <- map["Url"]
        ImageUrl <- map["ImageUrl"]
        Contract <- map["Contract"]
        ContractType <- map["ContractType"]
        ContractState <- map["ContractState"]
        IsIncludeTax <- map["IsIncludeTax"]
    }
}

class MessageFromModel: Mappable {
    var Avatar : String?
    var UserId : String?
    var ClientID : String?
    var PhoneNumber : String?
    var DisplayName : String?
    var Group : String?
    var UserType : String?
    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        Avatar <- map["Avatar"]
        UserId <- map["UserId"]
        ClientID <- map["ClientID"]
        PhoneNumber <- map["PhoneNumber"]
        DisplayName <- map["DisplayName"]
        UserType <- map["UserType"]
        Group <- map["Group"]
    }
}
class GroupModel: Mappable {
    
    var GroupName : String?
    var GroupPhoto : String?
    required init?(map: Map) {
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        GroupName <- map["GroupName"]
        GroupPhoto <- map["GroupPhoto"]
    }
    
    
}
