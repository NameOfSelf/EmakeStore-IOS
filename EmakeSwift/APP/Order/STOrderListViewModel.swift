//
//  STOrderListViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

class STOrderListViewModel: NSObject {

    func getOrderList(_ viewController:UIViewController,parameters:NSDictionary,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock)  {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getOrderList(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let userList = Mapper<STOrderModel>().mapArray(JSONArray: model.Data as! [[String : Any]])
                successBlock(userList)
            }else{
                failedBlock("")
            }
        }) { (error) in
            failedBlock(error)
        }
    }
}
