//
//  STUserInfoModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper

class STUserOrderModel: Mappable {
    var ContractNo : String?
    var InDate : String?
    var ContractAmount : Double?
    var OrderState : String?
    var ContractQuantity : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ContractNo <- map["ContractNo"]
        InDate <- map["InDate"]
        ContractAmount <- map["ContractAmount"]
        OrderState <- map["OrderState"]
        OrderState <- map["OrderState"]
    }
    
    
}
