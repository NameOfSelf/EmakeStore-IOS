//
//  RequestManager.swift
//  MySwiftTest
//
//  Created by 谷伟 on 2017/10/22.
//  Copyright © 2017年 谷伟. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire
import ObjectMapper
public func defaultAlamofireManager()->Manager{
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    
    let policies: [String: ServerTrustPolicy] = [
        
        "api.emake.cn": .disableEvaluation
    ]
    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    
    manager.startRequestsImmediately = false
    return manager
}
private func endpointMapping<Target:TargetType>(target:Target) -> Endpoint<Target>{
    
    print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.task))")
    
    return MoyaProvider.defaultEndpointMapping(for: target)
    
}
public final class RequestManager: NSObject{
    
    private let viewController : UIViewController
    let provider : MoyaProvider<APIManager>
    init(_  vc: UIViewController) {
        self.viewController = vc
        provider = MoyaProvider<APIManager>(endpointClosure: endpointMapping,manager:defaultAlamofireManager(),plugins:[RequestLoadingPlugin(self.viewController,true),AccessTokenPlugin(self.viewController), NetworkLoggerPlugin(verbose: true),newworkActivityPlugin,AuthPlugin()])
    }
}

