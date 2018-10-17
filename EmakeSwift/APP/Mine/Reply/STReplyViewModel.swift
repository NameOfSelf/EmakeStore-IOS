//
//  STReplyViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
import Moya
class STReplyViewModel: NSObject {

    func getAutoReplyInfo(_ viewController:UIViewController,pamameters:NSDictionary,successBlock:@escaping SuccessResponseBlock){
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getAutoReplyInfo(parameter: pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            if model.ResultCode == 0{
                let replyModel = Mapper<STReplyModel>().mapArray(JSONArray: [model.Data as! [String : Any]])
                successBlock(replyModel)
            }else{
                
            }
        }) { (error) in
            print(error)
        }
    }
}
