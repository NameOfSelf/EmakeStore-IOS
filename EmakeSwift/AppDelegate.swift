//
//  AppDelegate.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/1/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import Toast
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var timer : Timer?
    var count : Int? = 0
    var backIden : UIBackgroundTaskIdentifier?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //允许使用IQKeyboardManager
        IQKeyboardManager.sharedManager().enable = true
        
        //注册通知
        JZUserNotification.shared().register()
       
        //MQTT
        MQTTClientDefault.initMQTT()
        if UserDefaults.standard.object(forKey: EmakeUserServiceID) != nil{
            let userId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
            let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
            MQTTClientDefault.shared().connectToHost(withServerId: userId,storeID:storeId)
        }
        
        application.statusBarStyle = .lightContent
        self.window = UIWindow()
        self.window!.backgroundColor = BaseColor.BackgroundColor;
        self.window!.frame = UIScreen.main.bounds
        self.window!.rootViewController = BaseTabBarController()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.beginTask()
        count = 0
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(go(_:)), userInfo: nil, repeats: true)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if self.window != nil {
            if UserDefaults.standard.object(forKey: EmakeToken) == nil{
                Tools.getCurrentViewController().view.makeToast("请登录后重新操作", duration: 1.0, position: CSToastPositionBottom)
                return true
            }
            let MessageId = UUID.init().uuidString
            let fileNameStr = url.lastPathComponent
            let fileNameTotal = String(format: "%@_%@", arguments: [MessageId,fileNameStr])
            let localPath = String(format: "%@/Documents/%@.png", arguments: [NSHomeDirectory(),fileNameTotal])
            var fileData : Data?
            do {
                fileData = try Data.init(contentsOf: url)
                if !FileManager.default.fileExists(atPath: localPath) {
                    do {
                        try fileData?.write(to: URL(fileURLWithPath: localPath))
                    }catch {
                        
                    }
                }
                let vc = STFileMessageListViewController()
                vc.fileData = fileData
                vc.filePath = MessageId
                vc.fileName = fileNameStr
                Tools.getCurrentNavigationController().pushViewController(vc, animated: true)
            }catch {
                print("write image file error")
                return true
            }
        }
        return true
    }
    
    @objc func go(_ timer:Timer) {
        
        count = count! + 1
        if count == (24*60*60) {
            self.timer?.invalidate()
            self.endTask()
        }
    }

    func beginTask() {
        
        self.backIden = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.endTask()
        })
    }
    
    func endTask() {
        UIApplication.shared.endBackgroundTask(self.backIden!)
        self.backIden = UIBackgroundTaskInvalid
    }
}

