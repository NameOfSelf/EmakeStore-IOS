//
//  STUserInfoFooterView.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STUserInfoFooterView: UIView {

    var noMoreDataImage : UIImageView?
    var labelText : UILabel?
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configSubViews()
        self.snapSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews() {
        
        self.noMoreDataImage = UIImageView()
        self.noMoreDataImage?.image = UIImage(named:"icon_no_data")
        self.addSubview(self.noMoreDataImage!)
        
        self.labelText = UILabel()
        self.labelText?.textColor = TextColor_333333
        self.labelText?.font = AdaptFont(actureValue: 13)
        self.labelText?.text = "该用户还没有订单"
        self.addSubview(self.labelText!)
    }
    
    private func snapSubviews() {
        
        self.noMoreDataImage?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(WidthRate(actureValue: 148))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(HeightRate(actureValue: 25))
        })
        
        self.labelText?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo((self.noMoreDataImage?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
