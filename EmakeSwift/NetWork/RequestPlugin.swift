//
//  RequestPlugin.swift
//  MySwiftTest
//
//  Created by 谷伟 on 2017/10/22.
//  Copyright © 2017年 谷伟. All rights reserved.
//

import UIKit
import Moya
import Result
import MBProgressHUD
import Toast

let newworkActivityPlugin = NetworkActivityPlugin { (change,target)  -> () in
    
    switch(change){
        
    case .ended:
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    case .began:
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

public final class RequestLoadingPlugin : PluginType{
    
    private let viewController: UIViewController
    var HUD : MBProgressHUD
    var hide : Bool
    
    init(_ vc: UIViewController,_ hideView:Bool) {
        self.viewController = vc
        self.hide = hideView
        HUD = MBProgressHUD.init()
        guard self.hide else {
            return
        }
        HUD = MBProgressHUD.showAdded(to: self.viewController.view, animated: true)
    }
    public func willSend(_ request: RequestType, target: TargetType) {
        print("开始请求\(self.viewController)")
        if self.hide  != false  {
            HUD.mode = MBProgressHUDMode.indeterminate
            HUD.label.text = "加载中"
            HUD.label.font = AdaptFont(actureValue: 14)
            HUD.bezelView.color = UIColor.white
            HUD.removeFromSuperViewOnHide = true
            HUD.backgroundView.style = .solidColor //或SolidColor
        }
    }
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("结束请求")
        HUD.hide(animated: true)
    }
}

final class AuthPlugin : PluginType{
    
    init() {
    }
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        var token : String = ""
        request.timeoutInterval = 10
        if UserDefaults.standard.object(forKey: EmakeToken) != nil{
            token = UserDefaults.standard.object(forKey: EmakeToken) as! String
        }else{
            token = ""
        }

        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("emakeStore.ios."+(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String), forHTTPHeaderField: "User-Agent")
        request.addValue("version", forHTTPHeaderField: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        return request
    }
}

final class AccessTokenPlugin: PluginType {
    private let viewController: UIViewController
    private static var flag = false
    private static var flagAnother = false
    init(_ vc: UIViewController) {
        self.viewController = vc
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {}
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
            
        case .success(let response):
            //请求状态码
            guard  response.statusCode == 200 else {
                switch response.statusCode{
                case 500,502:
                    self.viewController.view.makeToast("服务端异常", duration: 1.0, position: CSToastPositionCenter)
                    return
                case 404:
                    self.viewController.view.makeToast("请求路径错误", duration: 1.0, position: CSToastPositionCenter)
                    return
                    //账号其他地方登陆
                case 403:
                    self.loginAgain()
                    return
                    //token失效刷新token
                case 401:
                    self.refreshToken()
                    return
                default:
                    self.viewController.view.makeToast("网络异常，请检查网络", duration: 1.0, position: CSToastPositionCenter)
                    return
                }
            }
            var json:Dictionary? = try! JSONSerialization.jsonObject(with: response.data,
                                                                     options:.allowFragments) as! [String: Any]
            print("请求状态码\(json?["ResultCode"] ?? "")")
            guard (json?["ResultInfo"]) != nil  else {
                return
            }
            guard let codeString = json?["ResultCode"]else {return}
            //请求状态为1时候立即返回不弹出任何提示 否则提示后台返回的错误信息
            if codeString as! Int != 0 {
                self.viewController.view.makeToast(json?["ResultInfo"] as! String, duration: 1.0, position: CSToastPositionCenter)
                return
            }

        case .failure(let error):
            print("请求错误----\(error)")
            self.viewController.view.makeToast("网络异常", duration: 1.0, position: CSToastPositionCenter)
            break
        }
    }
    //使用🔒保证多次异步调用只执行一次
    func loginAgain() {
        let lock = NSLock.init()
        lock.lock()
        if !(AccessTokenPlugin.flag) {
            MQTTClientDefault.shared().disConnect()
            UserDefaultClean()
            let loginVC = LoginViewController()
            let currentNav = Tools.getCurrentNavigationController()
            currentNav.hidesBottomBarWhenPushed = true
            currentNav.pushViewController(loginVC, animated: true)
            AccessTokenPlugin.flag = true;
        }
        lock.unlock()
    }
    
    func refreshToken() {
        let lock = NSLock.init()
        lock.lock()
        if !(AccessTokenPlugin.flagAnother) {
            let refreshToken = UserDefaults.standard.object(forKey: EmakeRefreshToken)
            UserDefaults.standard.set(refreshToken, forKey: EmakeToken)
            let viewModel = ResopnseViewModel()
            let currentVC = Tools.getCurrentViewController()
            let parameters: NSDictionary = ["refresh_token":refreshToken!]
            viewModel.refreshToken(currentVC,pamameters:parameters)
            AccessTokenPlugin.flagAnother = true;
        }
        lock.unlock()
    }
}


