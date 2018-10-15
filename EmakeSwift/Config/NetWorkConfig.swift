//
//  NetWorkConfig.swift
//  MySwiftTest
//
//  Created by 谷伟 on 2017/10/21.
//  Copyright © 2017年 谷伟. All rights reserved.
//

import UIKit

//上线
let Debug = "0"


enum WebViewURL : String {

    case InstuctionURL = "http://webtest.emake.cn/usinghelp/merchants"
    case ContractURL = "http://mallapi.emake.cn:5100/contract/"
}


/*
 请求回调
 */
typealias SuccessResponseBlock = (Any?) ->Void

typealias FailureResponseBlock = (Any?) ->Void


/*
 网络数据解析层
 */
let EmakeResultCode   = "ResultCode"
let EmakeResultInfo   = "ResultInfo"
let EmakeResponseData = "Data"


/*
 Emake地址
 */
//let EmakeHost = "http://mallapi.emake.cn/"
let EmakeHost = "http://mallapi.emake.cn/"
let EmakeHostTest = "http://192.168.0.191:3100/"


/*
 Emake全部接口
 */

//用户登录
let EmakeAPI_UserLogin = "user/login"
//发送验证码(1注册，2忘记密码)
let EmakeAPI_StoreSendVerificationCode = "store/send/verificationcode"
//注册
let EmakeAPI_StoreRegist = "store/regist"
//登录
let EmakeAPI_StoreLogin = "store/login"
//未成交vip用户
let EmakeAPI_AppVipUsers = "app/vip/users"
//已成交用户
let EmakeAPI_AppTransactionUsers = "app/transaction/users"
//获取店铺信息
let EmakeAPI_AppMyStore = "app/my/store2/"
//获取某个用户在该商铺的订单
let EmakeAPI_AppTransactionOrders = "app/transaction/orders"
//查看自动回复
let EmakeAPI_WebAutoReply = "app/store/auto_reply"
//忘记密码
let EmakeAPI_UserPasswordForget = "store/password/forget"
//token刷新
let EmakeAPI_AccessToken = "access_token"
//订单列表
let EmakeAPI_AppCustomerMakeOrder = "app/customer/make/order"
//物流列表
let EmakeAPI_AppMakeShippingDetail = "app/make/shipping/detail"
//用户搜索
let EmakeAPI_AppStoreGetusers = "app/store/getusers"
//店铺商品
let EmakeAPI_AppStoreDetail = "app/factory/detail"
//快捷回复
let EmakeAPI_WebQuickReplay = "web/quickreplay"
//查看合同PDF
let EmakeAPI_APPContractPDF = "web/make/contract/chat"
//系统消息
let EmakeAPI_StoreSystemNews = "store/servergetsystempushnews"
