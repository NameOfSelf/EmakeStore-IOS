//
//  STMessageSystemModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper

class STMessageSystemModel: Mappable {
    
    var ResultCount : String?
    var ResultList : [STMessageSystemContentModel]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ResultCount <- map["ResultCount"]
        ResultList <- map["ResultList"]
    }
}
class STMessageSystemContentModel: Mappable {
    
    var PushContent : String?
    var SendTime : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        PushContent <- map["PushContent"]
        SendTime <- map["SendTime"]
    }
}
class STMessageSystemNewModel: Mappable {
    
    var Content : String?
    var NewsID : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        Content <- map["Content"]
        NewsID <- map["NewsID"]
    }
}

