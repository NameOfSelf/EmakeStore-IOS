//
//  STMesageListUserInfoModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/23.
//  Copyright © 2018年 谷伟. All rights reserved.
//
import UIKit
import ObjectMapper

class STMesageListUserInfoModel: Mappable {
    
    var MobileNumber : String?
    var RealName : String?
    var NickName : String?
    var IsVip : String?
    var RemarkName : String?
    var UserId : String?
    var UserIdentity : String?
    var IsAgent : String?
    var HeadImageUrl : String?
    var RemarkCompany : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        MobileNumber <- map["MobileNumber"]
        RealName <- map["RealName"]
        NickName <- map["NickName"]
        IsVip <- map["IsVip"]
        RemarkName <- map["RemarkName"]
        UserId <- map["UserId"]
        UserIdentity <- map["UserIdentity"]
        IsAgent <- map["IsAgent"]
        HeadImageUrl <- map["HeadImageUrl"]
        RemarkCompany <- map["RemarkCompany"]
    }
}
