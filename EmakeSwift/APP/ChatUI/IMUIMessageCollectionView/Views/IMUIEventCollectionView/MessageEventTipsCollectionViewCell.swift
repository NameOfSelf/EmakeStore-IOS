//
//  MessageEventTipsCollectionViewCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/9.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class MessageEventTipsCollectionViewCell: UICollectionViewCell {
    
    var tipsLabel : UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configSubViews(){
        
        self.tipsLabel = UILabel()
        self.tipsLabel?.backgroundColor = TextColor_E6E6E6
        self.tipsLabel?.font = AdaptFont(actureValue: 12)
        self.tipsLabel?.numberOfLines = 0
        self.tipsLabel?.textAlignment = .center
        self.contentView.addSubview(self.tipsLabel!)
        
        self.tipsLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(HeightRate(actureValue: 5))
            make.bottom.equalTo(0)
            make.width.equalTo(WidthRate(actureValue:80))
            make.centerX.equalTo(self.contentView.snp.centerX)
        })
    }
    
    func presentCell(tips: String) {
        
        self.tipsLabel?.text = tips
        let width = 12*(self.tipsLabel?.text?.count)! + 20
        self.tipsLabel?.snp.updateConstraints({ (make) in
            make.width.equalTo(WidthRate(actureValue: CGFloat(width)))
        })
    }
}
