//
//  STOrderDetailViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/25.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

class STOrderDetailViewModel: NSObject {

    func getShipingInfo(_ viewController:UIViewController,parameters:NSDictionary,successBlock:@escaping SuccessResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getShippingDetail(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let logosticsList = Mapper<STLogosticsModel>().mapArray(JSONArray: model.Data as! [[String : Any]])
            successBlock(logosticsList)
        }) { (error) in
            
        }
    }
    
    func getContractAgreement(_ viewController:UIViewController,parameters:NSDictionary,successBlock:@escaping SuccessResponseBlock) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.getContractPDF(parameter: parameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let contract = Mapper<ContractModel>().map(JSON: model.Data as! [String : Any])
            successBlock(contract)
        }) { (error) in
            
        }
    }
}
