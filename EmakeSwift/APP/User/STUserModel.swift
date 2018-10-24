//
//  STUserModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STUserModel: Mappable {
    var UserName : String?
    var MobileNumber : String?
    var RealName : String?
    var HeadImageUrl : String?
    var UserId : String?
    var UserIdentity : String?
    var NickName : String?
    var Sex : String?
    var TotalAmount : Double?
    var TotalOrders : Int?
    var TotalQuantity : Int?
    var CreateTime : String?
    var EndAt : String?
    var RemarkCompany : String?
    var RemarkName : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        UserName <- map["UserName"]
        MobileNumber <- map["MobileNumber"]
        RealName <- map["RealName"]
        HeadImageUrl <- map["HeadImageUrl"]
        UserId <- map["UserId"]
        UserIdentity <- map["UserIdentity"]
        NickName <- map["NickName"]
        Sex <- map["Sex"]
        TotalAmount <- map["TotalAmount"]
        TotalQuantity <- map["TotalQuantity"]
        TotalOrders <- map["TotalOrders"]
        CreateTime <- map["CreateTime"]
        EndAt <- map["EndAt"]
        RemarkCompany <- map["RemarkCompany"]
        RemarkName <- map["RemarkName"]
    }
}

class STUserDataModel: Mappable {
    var ResultCount : Int?
    var ResultList : [STUserModel]?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        ResultCount <- map["ResultCount"]
        ResultList <- map["ResultList"]
    }
}
