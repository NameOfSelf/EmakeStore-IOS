//
//  STLogosticsModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STLogosticsModel: Mappable {
    var ShippingState : String?
    var ShippingRemark : String?
    var ShippingFee : String?
    var ReceiverAddress : String?
    var ContractNo : String?
    var LogisticsBillNo : String?
    var ShippingPhone : String?
    var ReceiverPhone : String?
    var ShippingNo : String?
    var ShippingPlate : String?
    var Receiver : String?
    var ShippingDate : String?
    var ShippingName : String?
    var Goods : [STLogosticsGoodsModel]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ShippingState <- map["ShippingState"]
        ShippingRemark <- map["ShippingRemark"]
        LogisticsBillNo <- map["LogisticsBillNo"]
        ShippingState <- map["ShippingState"]
        ReceiverAddress <- map["ReceiverAddress"]
        ContractNo <- map["ContractNo"]
        ShippingPhone <- map["ShippingPhone"]
        ReceiverPhone <- map["ReceiverPhone"]
        ShippingNo <- map["ShippingNo"]
        ShippingPlate <- map["ShippingPlate"]
        Receiver <- map["Receiver"]
        ShippingDate <- map["ShippingDate"]
        ShippingName <- map["ShippingName"]
        Goods <- map["Goods"]
    }

}
class STLogosticsGoodsModel: Mappable {
    var GoodsReName : String?
    var ShippingNumber : Int?
    var GoodsCode : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        GoodsCode <- map["GoodsCode"]
        GoodsReName <- map["GoodsReName"]
        ShippingNumber <- map["ShippingNumber"]
    }
}

class ContractModel: Mappable {
    var ContractState : String?
    var Products : [GoodsModel]?
    var MessageBody : ContractClassifyModel?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ContractState <- map["ContractState"]
        Products <- map["Products"]
        MessageBody <- map["MessageBody"]
    }
    
}
class GoodsModel: Mappable {
    var GoodsName : String?
    var GoodsPrice : Double?
    var MainGoodsCode : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        GoodsName <- map["GoodsName"]
        GoodsPrice <- map["GoodsPrice"]
        MainGoodsCode <- map["MainGoodsCode"]
    }
}

class ContractClassifyModel: Mappable {
    var ContractAgreement : ContractInfo?
    var ContractHeader : ContractInfo?
    var ContractTotal : ContractInfo?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ContractAgreement <- map["ContractAgreement"]
        ContractHeader <- map["ContractHeader"]
        ContractTotal <- map["ContractTotal"]
    }
}

class ContractInfo: Mappable {
    var ContractState : String?
    var Url : String?
    var ImageUrl : String?
    var Text : String?
    var IsIncludeTax : String?
    var ContractType : String?
    var Image : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ContractState <- map["ContractState"]
        Text <- map["Text"]
        Url <- map["Url"]
        ImageUrl <- map["ImageUrl"]
        IsIncludeTax <- map["IsIncludeTax"]
        ContractType <- map["ContractType"]
        Image <- map["Image"]
    }
}
