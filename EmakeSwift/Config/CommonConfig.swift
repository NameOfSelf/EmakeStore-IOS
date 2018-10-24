//
//  CommonConfig.swift
//  MySwiftTest
//
//  Created by 谷伟 on 2017/10/21.
//  Copyright © 2017年 谷伟. All rights reserved.
//

import UIKit
/*
 常用
 */
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let TableViewHeaderNone = CGFloat(0.01)
let TableViewFooterNone = CGFloat(0.01)

let IS_IPHONE_X = (ScreenHeight == 812.0) ? true:false
let StatusBarHeight =  (IS_IPHONE_X) ? 44.0:20.0
let NavigationBarHeight =  (IS_IPHONE_X) ? 88.0:64.0
let TableBarHeight =  (IS_IPHONE_X) ? 83.0:49.0

/*
 app标识
 */
let EmakeStore = "emake_store"

/*
 适配宽高和字体大小
 */
func WidthRate(actureValue:CGFloat) -> CGFloat{
    
    return actureValue/375.0*ScreenWidth
}
func HeightRate(actureValue:CGFloat) -> CGFloat{
    
    return actureValue/667.0*ScreenHeight
}
func AdaptFont(actureValue:CGFloat) -> UIFont{
    
    return UIFont.systemFont(ofSize: actureValue/375.0*ScreenWidth)
}
func AdaptBoldFont(actureValue:CGFloat) -> UIFont{
    
    return UIFont.boldSystemFont(ofSize: actureValue/375.0*ScreenWidth)
}
/*
 通知
 */
let NotificationLoginRefresh = "NotificationLoginRefresh"

/*
 MQTT
 */
//let MQTT_IP    = "api.emake.cn"
//let MQTT_IP    = "192.168.0.106"
let MQTT_IP    = "mallapitest.emake.cn"
let MQTT_PORT  = 1883
//let MQTT_CMDTopic = "customer/" + (UserDefaults.standard.object(forKey:EmakeStoreId) as! String) + "/" + (UserDefaults.standard.object(forKey:EmakeUserServiceID) as! String)
//let MQTTClienID = "customer/" + (UserDefaults.standard.object(forKey:EmakeStoreId) as! String) + "/" + (UserDefaults.standard.object(forKey:EmakeUserServiceID) as! String)
//let MQTT_ServerTopic = "chatroom/" + (UserDefaults.standard.object(forKey:EmakeStoreId) as! String) + "/" + (UserDefaults.standard.object(forKey:EmakeUserServiceID) as! String)
//let MQTT_ServerChatRoomID = (UserDefaults.standard.object(forKey:EmakeStoreId) as! String) + "/" + (UserDefaults.standard.object(forKey:EmakeUserServiceID) as! String)

/*
 阿里云OSS
 */
let ALiYunOSSAccessKey = "LTAIGYyQ8ZKKH72N"
let ALiYunOSSSecretKey = "PrEtbqO724fBsVSw8spLWtSPpaJclM"
let ALiYunOSSEndPoint = "oss-cn-shanghai.aliyuncs.com"
let ALiYunOSSBucketNameImage = "img-emake-cn"
let ALiYunOSSBucketNameVoice = "voi-emake-cn"
let ALiYunOSSBucketNameImageObjectKey = "images/"
let ALiYunOSSBucketNameImageVoiceKey = "mqtt/"
let ALiYunOSSBucketNameImageFileKey = "files/"
let ALiYunOSSImagePath = "https://" + ALiYunOSSBucketNameImage + "." + ALiYunOSSEndPoint + "/" + ALiYunOSSBucketNameImageObjectKey
let ALiYunOSSVoicePath = "https://" + ALiYunOSSBucketNameVoice + "." + ALiYunOSSEndPoint + "/" + ALiYunOSSBucketNameImageVoiceKey
let ALiYunOSSFilePath = "https://" + ALiYunOSSBucketNameVoice + "." + ALiYunOSSEndPoint + "/" + ALiYunOSSBucketNameImageFileKey

/*
 通知
 */
let NotificatonOrderState      = "NotificatonOrderState"
let NotificatonRefreshCartData = "NotificatonRefreshCartData"

/*
 用户信息存储字段
 */
let EmakeToken = "EmakeToken"
let EmakeRefreshToken = "EmakeRefreshToken"
let EmakeHeadImageUrlString = "EmakeHeadImageUrlString"
let EmakeUserPhoneNumber = "EmakeUserPhoneNumber"
let EmakeUserRealName = "EmakeUserRealName"
let EmakeUserNickName = "EmakeUserNickName"
let EmakeUserPassword = "EmakeUserPassword"
let EmakeUserBusinessCategory = "EmakeUserBusinessCategory"
let EmakeUserServiceID = "EmakeUserServiceID"
let EmakeUserId = "EmakeUserId"
let EmakeShowPassView = "EmakeShowPassView"
let EmakeServerList = "EmakeServerList"
/*
 店铺信息存储字段
 */
let EmakeStoreId = "EmakeStoreId"
let EmakeStoreCategoryBId = "EmakeStoreCategoryBId"
let EmakeStoreState = "EmakeStoreState"
let EmakeStorePhoto = "EmakeStorePhoto"
let EmakeStoreName = "EmakeStoreName"
let EmakeStoreType = "EmakeStoreType"
let EmakeStoreCategoryBName = "EmakeStoreCategoryBName"

/*
 用户信息存储字段获取
 */



//存储信息清除
func UserDefaultClean() {
    
    UserDefaults.standard.removeObject(forKey: EmakeToken)
    UserDefaults.standard.removeObject(forKey: EmakeRefreshToken)
    UserDefaults.standard.removeObject(forKey: EmakeHeadImageUrlString)
    UserDefaults.standard.removeObject(forKey: EmakeUserPhoneNumber)
    UserDefaults.standard.removeObject(forKey: EmakeUserRealName)
    UserDefaults.standard.removeObject(forKey: EmakeUserNickName)
    UserDefaults.standard.removeObject(forKey: EmakeUserServiceID)
    UserDefaults.standard.removeObject(forKey: EmakeUserId)
    UserDefaults.standard.removeObject(forKey: EmakeShowPassView)
    UserDefaults.standard.removeObject(forKey: EmakeServerList)
    
    UserDefaults.standard.removeObject(forKey: EmakeStoreId)
    UserDefaults.standard.removeObject(forKey: EmakeStoreCategoryBId)
    UserDefaults.standard.removeObject(forKey: EmakeStorePhoto)
    UserDefaults.standard.removeObject(forKey: EmakeStoreName)
    UserDefaults.standard.removeObject(forKey: EmakeStoreType)
    UserDefaults.standard.removeObject(forKey: EmakeStoreState)
    UserDefaults.standard.removeObject(forKey: EmakeStoreCategoryBName)
}
