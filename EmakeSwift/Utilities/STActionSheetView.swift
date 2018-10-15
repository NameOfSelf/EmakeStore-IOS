//
//  STActionSheetView.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/7.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import SnapKit
//备注：初始化的frame设置CGRectZero
class STActionSheetView: UIView {
    let shadowView : UIView
    let cancleButton : UIButton
    weak var delegate : STActionSheetViewDelegate?
    init(frame: CGRect,titles:[String]) {
        self.shadowView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.cancleButton = UIButton()
        self.cancleButton.setTitle("取消", for: .normal)
        self.cancleButton.backgroundColor = .white
        self.cancleButton.layer.cornerRadius = 5
        self.cancleButton.setTitleColor(.black, for: .normal)
        self.cancleButton.titleLabel?.font = AdaptFont(actureValue: 16)
        self.cancleButton.layer.cornerRadius = WidthRate(actureValue: 5)
        
        super.init(frame: frame)
        
        //计算高度
        let height = CGFloat(titles.count+1)*HeightRate(actureValue: 55) + HeightRate(actureValue: 48)
        self.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: height)
        self.cancleButton.addTarget(self, action: #selector(cancle), for: .touchUpInside)
        self.addSubview(self.cancleButton)
        
        self.cancleButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-HeightRate(actureValue: 21))
            make.height.equalTo(HeightRate(actureValue: 55))
            make.width.equalTo(WidthRate(actureValue: 290))
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5;
        self.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.cancleButton.snp.top).offset(-HeightRate(actureValue: 21))
            make.height.equalTo(HeightRate(actureValue: CGFloat(55*titles.count)))
            make.width.equalTo(WidthRate(actureValue: 290))
            make.centerX.equalTo(self.snp.centerX)
        }
        
        for i in 0..<titles.count {

            let button = UIButton()
            button.tag = i
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
            button.titleLabel?.font = AdaptFont(actureValue: 16)
            button.addTarget(self, action: #selector(selectItem(_:)), for: .touchUpInside)
            view.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.bottom.equalTo(-HeightRate(actureValue: CGFloat(55*i)))
                make.height.equalTo(HeightRate(actureValue: 55))
                make.left.equalTo(WidthRate(actureValue: 3))
                make.right.equalTo(WidthRate(actureValue:-3))
                make.centerX.equalTo(self.snp.centerX)
            }
            
            if i != 0{
                let line = UILabel()
                line.backgroundColor = BaseColor.SepratorLineColor
                view.addSubview(line)
                line.snp.makeConstraints { (make) in
                    make.bottom.equalTo(-HeightRate(actureValue: CGFloat(55*i)))
                    make.height.equalTo(1)
                    make.left.equalTo(0)
                    make.right.equalTo(0)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.shadowView = UIView()
        self.cancleButton = UIButton()
        super.init(coder: aDecoder)
    }
    
    public func showAnimated() {
        
        UIApplication.shared.keyWindow?.addSubview(self.shadowView)
        self.shadowView.addSubview(self)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.bounds.size.height)
        }) { (finished) in
            
        }
    }
    
    @objc private func cancle(){
    
        self.shadowView.removeFromSuperview()
        
    }
    
    @objc private func selectItem(_ button:UIButton){
        
        self.shadowView.removeFromSuperview()
        self.delegate?.clickAtIndex(index: button.tag)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
protocol STActionSheetViewDelegate : NSObjectProtocol {
    
    func clickAtIndex(index:NSInteger)
}
