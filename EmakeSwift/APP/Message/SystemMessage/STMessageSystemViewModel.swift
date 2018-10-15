//
//  STMessageSystemViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STMessageSystemViewModel: NSObject {
    
    func getMessageSystem(_ viewController:UIViewController,parameters:NSDictionary,successBlock:@escaping SuccessResponseBlock,failedBlock:@escaping FailureResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getSystemNews(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let model = Mapper<STMessageSystemModel>().map(JSON: model.Data as! [String:Any])
            successBlock(model?.ResultList)
        }) { (error) in
            failedBlock(error)
        }
    }
}
