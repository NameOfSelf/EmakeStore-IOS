//
//  STOrderModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STOrderModel: Mappable {
    var AccountOfPartyA : String?
    var AddWhen : String?
    var Address : String?
    var BankOfPartyA : String?
    var ContractAmount : Double?
    var ContractNo : String?
    var ContractQuantity : Int?
    var CouponValue : Double?
    var GoodsAddValue : String?
    var HasPayFee : Double?
    var HeadImageUrl : String?
    var InDate : String?
    var InsurdAmount : String?
    var IsIncludeTax : String?
    var IsOut : String?
    var MobileNumber : String?
    var NameOfPartyA : String?
    var OrderState : String?
    var ProductList : [ProductModel]?
    var RealName : String?
    var RemainInvoiceAmount : String?
    var ShippingInfo : [ShippingInfoModel]?
    var StoreId : String?
    var StoreName : String?
    var SuperGroupDetailId : String?
    var StoreOwner : StoreOwnerModel?
    var StorePhoto : String?
    var UserId : String?
    var UserIdentity : String?
    var RemarkCompany : String?
    var RemarkName : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        AccountOfPartyA <- map["AccountOfPartyA"]
        AddWhen <- map["AddWhen"]
        Address <- map["Address"]
        BankOfPartyA <- map["BankOfPartyA"]
        ContractAmount <- map["ContractAmount"]
        ContractNo <- map["ContractNo"]
        ContractQuantity <- map["ContractQuantity"]
        CouponValue <- map["CouponValue"]
        GoodsAddValue <- map["GoodsAddValue"]
        HasPayFee <- map["HasPayFee"]
        HeadImageUrl <- map["HeadImageUrl"]
        InDate <- map["InDate"]
        InsurdAmount <- map["InsurdAmount"]
        IsIncludeTax <- map["IsIncludeTax"]
        IsOut <- map["IsOut"]
        MobileNumber <- map["MobileNumber"]
        NameOfPartyA <- map["NameOfPartyA"]
        OrderState <- map["OrderState"]
        ProductList <- map["ProductList"]
        RealName <- map["RealName"]
        RemainInvoiceAmount <- map["RemainInvoiceAmount"]
        ShippingInfo <- map["ShippingInfo"]
        StoreId <- map["StoreId"]
        StoreName <- map["StoreName"]
        StoreOwner <- map["StoreOwner"]
        StorePhoto <- map["StorePhoto"]
        UserId <- map["UserId"]
        SuperGroupDetailId <- map["SuperGroupDetailId"]
        UserIdentity <- map["UserIdentity"]
        RemarkCompany <- map["RemarkCompany"]
        RemarkName <- map["RemarkName"]
    }
}
class AddressModel: Mappable {
    var County : String?
    var UserId : String?
    var Province : String?
    var Address : String?
    var District : String?
    var UserName : String?
    var MobileNumber : String?
    var RefNo : String?
    var City : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        County <- map["County"]
        UserId <- map["UserId"]
        Province <- map["Province"]
        Address <- map["Address"]
        District <- map["District"]
        UserName <- map["UserName"]
        MobileNumber <- map["MobileNumber"]
        RefNo <- map["RefNo"]
        City <- map["City"]
    }
}
class ProductModel: Mappable {
    var AddServiceInfo : [ServiceInfoModel]?
    var GoodsExplain : String?
    var GoodsNumber : Int?
    var GoodsSeriesCode : String?
    var GoodsSeriesIcon : String?
    var GoodsSeriesPhotos : String?
    var GoodsTitle : String?
    var MainMakePrice : Double?
    var MainProductId : String?
    var MainProductPrice : Double?
    var ProductGroupPrice : Double?
    var TotalProductGroupPrice : Double?
    var TotalShippingFee : Double?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        AddServiceInfo <- map["AddServiceInfo"]
        GoodsExplain <- map["GoodsExplain"]
        GoodsNumber <- map["GoodsNumber"]
        GoodsSeriesCode <- map["GoodsSeriesCode"]
        GoodsSeriesIcon <- map["GoodsSeriesIcon"]
        GoodsTitle <- map["GoodsTitle"]
        MainMakePrice <- map["MainMakePrice"]
        MainProductId <- map["MainProductId"]
        MainProductPrice <- map["MainProductPrice"]
        ProductGroupPrice <- map["ProductGroupPrice"]
        TotalProductGroupPrice <- map["TotalProductGroupPrice"]
        TotalShippingFee <- map["TotalShippingFee"]
        GoodsSeriesPhotos <- map["GoodsSeriesPhotos"]
    }
}
class ServiceInfoModel: Mappable {
    var GoodsPrice : Double?
    var GoodsTitle : String?
    var GoodsType : String?
    var GoodsTypeName : String?
    var ProductId : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        GoodsPrice <- map["GoodsPrice"]
        GoodsTitle <- map["GoodsTitle"]
        GoodsType <- map["GoodsType"]
        GoodsTypeName <- map["GoodsTypeName"]
        ProductId <- map["ProductId"]
    }
}
class StoreOwnerModel: Mappable {
    var MobileNumber : String?
    var PSPDId : String?
    var RawCardUrl : String?
    var RealName : String?
    var UserId : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        MobileNumber <- map["MobileNumber"]
        PSPDId <- map["PSPDId"]
        RawCardUrl <- map["RawCardUrl"]
        RealName <- map["RealName"]
        UserId <- map["UserId"]
    }
}
class ShippingInfoModel: Mappable {
    var Receiver : String?
    var ReceiverAddress : String?
    var ReceiverPhone : String?
    var ShippingDate : String?
    var ShippingNo : String?
    var ShippingNumber : String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        Receiver <- map["Receiver"]
        ReceiverAddress <- map["ReceiverAddress"]
        ReceiverPhone <- map["ReceiverPhone"]
        ShippingDate <- map["ShippingDate"]
        ShippingNo <- map["ShippingNo"]
        ShippingNumber <- map["ShippingNumber"]
    }
}

