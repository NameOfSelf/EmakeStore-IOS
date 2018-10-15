//
//  STMessageConnvientReplyModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STMessageConnvientReplyModel: Mappable {
    var Content : String?
    var RefNo : String?
    var ProblemType : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Content <- map["Content"]
        RefNo <- map["RefNo"]
        ProblemType <- map["ProblemType"]
    }
    

    
}
