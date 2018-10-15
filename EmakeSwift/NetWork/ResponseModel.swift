//
//  ResponseModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/8/14.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class ResponseModel: Mappable {
    
    var ResultCode : Int?
    var ResultInfo : String?
    var Data : Any?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        ResultCode <- map[EmakeResultCode]
        ResultInfo <- map[EmakeResultInfo]
        Data <- map[EmakeResponseData]
    }
}
class TokenModel: Mappable {
    var Access_token : String?
    var Refresh_token : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Access_token <- map["Access_token"]
        Refresh_token <- map["Refresh_token"]
    }
    
    
}
