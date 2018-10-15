//
//  BaseTabBarController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/1/28.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import CYLTabBarController
class BaseTabBarController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = BaseColor.StatusAndTopBarColor
        self.tabBar.isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:BaseColor.APP_THEME_MAIN_COLOR], for: .selected)
        self.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)], for: .normal)
        let controllerName = ["STMessageListViewController","STUserListViewController","STOrderListViewController","STMineViewController"]
        let title = ["聊天","用户","订单","我的"]
        let selectedImages = ["icon_message_on","icon_ user_on","icon_orders_on","icon_mine_on"]
        let images = ["icon_message_off","icon_ user_off","icon_orders_off","icon_mine_off"]
        
        var tabBarItemsAttributes = [[AnyHashable: Any]]()
        var viewControllers : [UIViewController] = []
        
        for i in 0..<title.count {
            let dict : [AnyHashable : Any] = [
                CYLTabBarItemTitle :title[i],
                CYLTabBarItemImage: images[i],
                CYLTabBarItemSelectedImage: selectedImages[i]
            ]
            let cls:AnyClass?  = NSClassFromString(String("EmakeSwift." + controllerName[i]))
            
            let viewControllerCls = cls as! UIViewController.Type
            
            let vc = viewControllerCls.init()
            
            let nav = BaseNavigationViewController.init(rootViewController: vc)
            
            tabBarItemsAttributes.append(dict)
            
            viewControllers.append(nav)
        }
        self.tabBarItemsAttributes = tabBarItemsAttributes
        self.viewControllers = viewControllers

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
