//
//  STProductRecommendViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/28.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

class STProductRecommendViewModel: NSObject {

    func getStoreProduct(_ viewController:UIViewController,pamameters:NSDictionary,successBlock:@escaping SuccessResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getStoreDetail(parameter:
            pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let model = Mapper<STProductRecommendModel>().map(JSON: model.Data! as! [String : Any])
            successBlock(model)
        }) { (error) in
            
        }
    }
}
