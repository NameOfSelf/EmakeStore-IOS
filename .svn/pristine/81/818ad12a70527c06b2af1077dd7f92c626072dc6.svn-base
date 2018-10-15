//
//  BaseNavigationViewController.swift
//  MySwiftTest
//
//  Created by 谷伟 on 2017/10/20.
//  Copyright © 2017年 谷伟. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = UINavigationBar.appearance()
        // Do any additional setup after loading the view.
        navBar.barTintColor = BaseColor.StatusAndTopBarColor
        navBar.tintColor = BaseColor.BackgroundColor
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font:AdaptFont(actureValue: 18)]
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(), style: UIBarButtonItemStyle.plain, target: self, action: #selector(navigationBackClick))
            
            self.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        }
        super.pushViewController(viewController, animated: true)
    }
    @objc func navigationBackClick(){
        if (self.navigationController != nil) || (self.presentationController != nil) && (self.childViewControllers.count == 1){
            _ = dismiss(animated: true, completion: nil)
        }else{
            _ =  popViewController(animated: true)
        }
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
