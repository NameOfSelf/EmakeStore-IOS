//
//  STMessageConnvientReplyViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STMessageConnvientReplyViewModel: NSObject {

    func getConnvientReply(_ viewController:UIViewController,successBlock:@escaping SuccessResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getQuickReplay()).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let connvientReplyList = Mapper<STMessageConnvientReplyModel>().mapArray(JSONArray: model.Data as! [[String : Any]])
            successBlock(connvientReplyList)
        }) { (error) in
            
        }
    }
    
    
}
