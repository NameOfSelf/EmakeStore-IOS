//
//  Tools.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/8/15.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation
class Tools: NSObject {

    //获取当前window的ViewController
    public class func getCurrentViewController() -> BaseViewController{
        let window = UIApplication.shared.keyWindow
        let currentVC = window?.rootViewController
        let tabBarVC = currentVC as! BaseTabBarController
        let navc =  tabBarVC.selectedViewController as! BaseNavigationViewController
        return navc.visibleViewController as! BaseViewController
    }
    //获取当前window的NavigationController
    public class func getCurrentNavigationController() -> BaseNavigationViewController{
        
        return self.getCurrentViewController().navigationController as! BaseNavigationViewController
    }
    //手机号检查
    public class func isMobileNumber(mobilenumber:String)->Bool {
        
        let moblieString = "^1(3[0-9]|4[579]|5[0-35-9]|7[1-35-8]|8[0-9]|70)\\d{8}$"
        let regexTestMobile = NSPredicate(format: "SELF MATCHES %@",moblieString)
        return regexTestMobile.evaluate(with: mobilenumber)
    }
    //英文数字检查
    public class func judgeAccountOrPasswordLegal(text:String) ->Bool {
        
        let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
        let regexTest = NSPredicate(format: "SELF MATCHES %@",regex)
        return regexTest.evaluate(with: text)
    }
    //MD5加密
    public class func md5String(str:String) -> String{
        
        let cStrl = str.cString(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16);
        CC_MD5(cStrl, CC_LONG(strlen(cStrl!)), buffer);
        var md5String = "";
        for idx in 0...15 {
            let obcStrl = String.init(format: "%02x", buffer[idx]);
            md5String.append(obcStrl);
        }
        free(buffer);
        return md5String;
    }
    
}
