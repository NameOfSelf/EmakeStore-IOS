//
//  STMessageListViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/23.
//  Copyright © 2018年 谷伟. All rights reserved.
//
import UIKit
import ObjectMapper

class STMessageListViewModel: NSObject {

    func getUserInfo(_ viewController:UIViewController,parameters:NSDictionary,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getUserInfo(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let userInfo = Mapper<STMesageListUserInfoModel>().map(JSON: model.Data as! [String : Any])
            successBlock(userInfo)
        }) { (error) in
            failedBlock(error)
        }
        
    }
}
