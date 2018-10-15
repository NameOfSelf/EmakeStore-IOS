//
//  MessageOrderModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class MessageOrderModel: Mappable {
    var ContractAmount : String?
    var IsStore : String?
    var GoodsTitle : String?
    var ContractQuantity : String?
    var ContractNo : String?
    var GoodsExplain : String?
    var GoodsSeriesIcon : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ContractAmount <- map["ContractAmount"]
        IsStore <- map["IsStore"]
        GoodsTitle <- map["GoodsTitle"]
        ContractQuantity <- map["ContractQuantity"]
        ContractNo <- map["ContractNo"]
        GoodsExplain <- map["GoodsExplain"]
        GoodsSeriesIcon <- map["GoodsSeriesIcon"]
    }
    

}
