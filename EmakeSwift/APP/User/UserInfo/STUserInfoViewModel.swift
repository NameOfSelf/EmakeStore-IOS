//
//  STUserInfoViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
import Moya

class STUserInfoViewModel: NSObject {

    func getTransactionOrders(_ viewController:UIViewController,pamameters:NSDictionary,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getTransactionOrders(parameter: pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let orderList = Mapper<STUserOrderModel>().mapArray(JSONArray: model.Data as! [[String : Any]])
                successBlock(orderList)
            }else{
                failedBlock("error")
            }
        }) { (error) in
            failedBlock(error)
        }
    }
}
