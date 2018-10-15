//
//  STUserListViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/5.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STUserListViewModel: NSObject {

    func getUsersList(_ viewController:UIViewController,pamameters:NSDictionary,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock){
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getVipUsers(parameter: pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let userList = Mapper<STUserModel>().mapArray(JSONArray: model.Data as! [[String : Any]])
                successBlock(userList)
            }
        }) { (error) in
            failedBlock(error)
        }
    }
    
    func getTransactionUsers(_ viewController:UIViewController,pamameters:NSDictionary,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getTransactionUsers(parameter: pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let userList = Mapper<STUserModel>().mapArray(JSONArray: model.Data as! [[String : Any]])
                successBlock(userList)
            }
        }) { (error) in
            failedBlock(error)
        }
    }
    
    func searchUserList(_ viewController:UIViewController,pamameters:NSDictionary,successBlock:@escaping SuccessResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.searchUser(parameter: pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let result = Mapper<STUserDataModel>().map(JSON: model.Data! as! [String : Any])
            successBlock(result?.ResultList)
        }) { (error) in
            
        }
    }
}
