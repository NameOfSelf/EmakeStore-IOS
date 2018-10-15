//
//  STTitleSelectView.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STTitleSelectView: UIView {
    var lineView : UIView?
    var titles : [String]?
    weak var delgate : STTitleSelectViewDelgate?
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,titles:[String]) {
        self.init(frame: frame)
        self.configSubViews(titles:titles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews(titles:[String]) {
        self.titles = titles
        for i in 0..<titles.count {
            let button = UIButton(type: .custom)
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = AdaptFont(actureValue: 15)
            button.tag = i+100;
            button.frame = CGRect(x: frame.size.width*CGFloat(i)/CGFloat(titles.count), y: 0, width: frame.size.width/CGFloat(titles.count), height: frame.size.height)
            button.addTarget(self, action: #selector(selectItem(_:)), for: .touchUpInside)
            self.addSubview(button)
            if i == 0 {
                button.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
                let rect = NSString(string: titles[i]).size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)])
                self.lineView = UIView(frame: CGRect(x: 0, y: frame.size.height-HeightRate(actureValue: 3), width: rect.width, height: HeightRate(actureValue: 3)))
                self.lineView?.center.x = button.center.x
                self.lineView?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
                self.addSubview(self.lineView!)
            }
        }

    }
    
    @objc private func selectItem(_ button:UIButton){
        
        for i in 0..<self.titles!.count{
            let buttonGet = self.viewWithTag(i+100) as! UIButton
            buttonGet.setTitleColor(.black, for: .normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            button.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
            let rect = NSString(string: self.titles![button.tag - 100]).size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)])
            self.lineView?.frame.size.width = rect.width
            self.lineView?.center.x = button.center.x;
        }
        self.delgate?.selectItemWithIndex(index: button.tag-100)
    }
    
    public func changeItemWithIndex(index:NSInteger){
        
        let buttonGet = self.viewWithTag(index+100) as! UIButton
        buttonGet.setTitleColor(.black, for: .normal)
        for i in 0..<self.titles!.count{
            let buttonGet = self.viewWithTag(i+100) as! UIButton
            buttonGet.setTitleColor(.black, for: .normal)
        }
        UIView.animate(withDuration: 0.5) {
            buttonGet.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
            let rect = NSString(string: self.titles![buttonGet.tag - 100]).size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)])
            self.lineView?.frame.size.width = rect.width
            self.lineView?.center.x = buttonGet.center.x;
        }
    }
}
protocol STTitleSelectViewDelgate :NSObjectProtocol {
    
    func selectItemWithIndex(index:NSInteger)
}
