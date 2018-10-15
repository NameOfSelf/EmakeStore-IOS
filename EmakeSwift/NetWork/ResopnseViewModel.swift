//
//  ResopnseViewModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/21.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
class ResopnseViewModel: NSObject {

    func refreshToken(_ viewController:UIViewController,pamameters:NSDictionary) {
        let request = RequestManager.init(viewController)
        let _ = request.provider.rx.request(.refreshToken(parameter: pamameters)).mapObject(ResponseModel.self).subscribe(onSuccess: { (model) in
            let tokenModel = Mapper<TokenModel>().map(JSON: model.Data! as! [String : Any])
            UserDefaults.standard.set(tokenModel?.Refresh_token, forKey: EmakeRefreshToken)
            UserDefaults.standard.set(tokenModel?.Access_token, forKey: EmakeToken)
            UserDefaults.standard.synchronize()
        }) { (error) in
            
        }
    }
    
}
