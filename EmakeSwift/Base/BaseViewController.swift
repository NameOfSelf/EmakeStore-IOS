//
//  BaseViewController.swift
//  MySwiftTest
//
//  Created by 谷伟 on 2017/10/21.
//  Copyright © 2017年 谷伟. All rights reserved.
//

import UIKit
import SnapKit
enum Direction : String {
    case left,right
}
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BaseColor.BackgroundColor
        self.edgesForExtendedLayout = UIRectEdge()
        self.configSubviews()
        self.snapSubviews()
        // Do any additional setup after loading the view.
    }
    //页面布局
    public func configSubviews(){
        
    }
    //页面限制
    public func snapSubviews(){
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
extension BaseViewController{
    
    //设置左边item以及返回方式
    func baseSetNavLeftButtonIsBack(){
        baseSetNavButtonWith(nil, imageName: "left", button: nil, direction: .left, tag: 100)
    }
    func baseSetNavLeftButtonIsDissmiss(){
        baseSetNavButtonWith(nil, imageName: "left", button: nil, direction: .left, tag: 200)
    }
    
    // 设置左边
    func baseSetNavLeftButtonWithTitle(_ title:String){
        baseSetNavButtonWith(title, imageName: nil, button: nil, direction: .left, tag : 0)
    }
    func baseSetNavLeftButtonWithImage(_ imageName :String) {
        baseSetNavButtonWith(nil, imageName: imageName, button: nil, direction: .left, tag : 0)
    }
    func baseSetNavLeftButtonWithButton(_ button : UIButton) {
        baseSetNavButtonWith(nil, imageName: nil, button: button, direction: .left, tag : 0)
    }

    // 设置右边
    func baseSetNavRightButtonWithTitle(_ title : String) {
        self.baseSetNavButtonWith(title, imageName: nil, button: nil, direction: .right, tag: 0)
    }
    func baseSetNavRightButtonWithImage(_ imageName : String) {
        self.baseSetNavButtonWith(nil, imageName: imageName, button: nil, direction: .right, tag : 0)
    }
    func baseSetNavRightButtonWithButton(_ button : UIButton) {
        self.baseSetNavButtonWith(nil, imageName: nil, button: button, direction: .right, tag : 0)
    }
    fileprivate func baseSetNavButtonWith(_ title:String?,imageName:String?,button : UIButton?,direction:Direction,tag:Int){
        
        var btn : UIButton! = UIButton.init(type: .custom)
        var action : Selector? = nil
        
        switch direction {
        case .left:
            action = #selector(baseNavLeftButtonPressed(_:))
        case .right:
            action = #selector(baseNavRightButtonPressed(_:))
        }
        if title != nil {
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.addTarget(self, action: action!, for: .touchUpInside)
        }
        if imageName != nil{
            btn.setImage(UIImage(named: imageName!), for: .normal)
            btn.addTarget(self, action: action!, for: .touchUpInside)
        }
        if button != nil{
            btn = button
        }
        btn.tag = tag
        btn.sizeToFit()
        let barBtnItem = UIBarButtonItem.init(customView: btn)
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        switch direction {
        case .left:
            self.navigationItem.leftBarButtonItems = [spaceItem,barBtnItem]
        default:
            self.navigationItem.rightBarButtonItems = [barBtnItem,spaceItem]
        }
    }
    //右边按钮点击方法
    @objc func baseNavRightButtonPressed(_ button : UIButton){
        
    }
    @objc func baseNavLeftButtonPressed(_ button: UIButton){
        switch button.tag {
        case 100:
            _ = self.navigationController?.popViewController(animated: true)
        default:
            _ = self.dismiss(animated: true, completion: nil)
        }
    }
    
}