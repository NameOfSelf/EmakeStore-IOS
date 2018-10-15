//
//  STProductRecommendModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/28.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STProductRecommendModel: Mappable {
    var MobileNumber : String?
    var StoreCategoryList : [String]?
    var StoreBusinessCategory : [String]?
    var RealName : String?
    var StoreName : String?
    var StoreId : String?
    var StoreOwner : StoreOwnerModel?
    var RefNo : String?
    var StoreSales : String?
    var IsCollect : String?
    var StoreSummary : String?
    var StoreOrders : String?
    var CategoryList : [CategoryListModel]?
    var StorePhoto : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        MobileNumber <- map["MobileNumber"]
        StoreCategoryList <- map["StoreCategoryList"]
        StoreBusinessCategory <- map["StoreBusinessCategory"]
        RealName <- map["RealName"]
        StoreName <- map["StoreName"]
        StoreId <- map["StoreId"]
        StoreOwner <- map["StoreOwner"]
        RefNo <- map["RefNo"]
        StoreSales <- map["StoreSales"]
        IsCollect <- map["IsCollect"]
        StoreSummary <- map["StoreSummary"]
        StoreOrders <- map["StoreOrders"]
        CategoryList <- map["CategoryList"]
        StorePhoto <- map["StorePhoto"]
    }
}
class CategoryListModel: Mappable {
    var CategorySeries : [CategorySeriesModel]?
    var CategoryId : String?
    var CategoryName : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        CategorySeries <- map["CategorySeries"]
        CategoryId <- map["CategoryId"]
        CategoryName <- map["CategoryName"]
    }
}
class CategorySeriesModel: Mappable {
    var GoodsPriceMax : String?
    var GoodsSeriesName : String?
    var GoodsSeriesIcon : String?
    var GoodsSale : String?
    var PriceRange : String?
    var GoodsSeriesCode : String?
    var GoodsPriceMin : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        GoodsPriceMax <- map["GoodsPriceMax"]
        GoodsSeriesName <- map["GoodsSeriesName"]
        GoodsSeriesIcon <- map["GoodsSeriesIcon"]
        GoodsSale <- map["GoodsSale"]
        PriceRange <- map["PriceRange"]
        GoodsSeriesCode <- map["GoodsSeriesCode"]
        GoodsPriceMin <- map["GoodsPriceMin"]
    }
}
class ProductItemModel: Mappable {
    var GoodsImageUrl : String?
    var GoodsPriceValue : String?
    var CategoryId : String?
    var GoodsSeriesCode : String?
    var GoodsSeriesName : String?
    var GoodsDetailUrl : String?
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        GoodsImageUrl <- map["GoodsImageUrl"]
        GoodsSeriesName <- map["GoodsSeriesName"]
        CategoryId <- map["CategoryId"]
        GoodsPriceValue <- map["GoodsPriceValue"]
        GoodsSeriesCode <- map["GoodsSeriesCode"]
        GoodsDetailUrl <- map["GoodsDetailUrl"]
    }
}
