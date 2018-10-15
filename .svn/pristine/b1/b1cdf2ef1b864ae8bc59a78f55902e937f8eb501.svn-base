//
//  LoginViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/18.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper
class LoginViewModel: NSObject {
    
    func login(_ viewController:UIViewController,parameters:NSDictionary,successBlock:@escaping SuccessResponseBlock){
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.login(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let loginModel = Mapper<LoginModel>().map(JSON: model.Data! as! [String : Any])
                successBlock(loginModel)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getStoreInfo(_ viewController:UIViewController,successBlock:@escaping SuccessResponseBlock)  {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getStoreInfo()).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let storeModel =  Mapper<StoreModel>().map(JSON: model.Data! as! [String : Any])
                successBlock(storeModel)
            }
        }) { (error) in
            print(error)
        }
    }
}
