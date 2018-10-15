//
//  RegisterViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/18.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper
class RegisterViewModel: NSObject {

    func getVerifyCode(_ viewController:UIViewController,parameters:NSDictionary) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getVerifyCode(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            print(model.ResultInfo!)
        }) { (error) in
            print(error)
        }
    }
    
    func regist(_ viewController:UIViewController,parameters:NSDictionary,succussBlock:@escaping SuccessResponseBlock){
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.register(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                succussBlock(model.ResultInfo)
            }
        }) { (error) in
            print(error)
        }
    }
}
