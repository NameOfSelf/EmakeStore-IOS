//
//  STUserInfoCommonCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STUserInfoCommonCell: UITableViewCell {
    
    var leftTitle : UILabel?
    var rightTitle : UILabel?
    var line : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snapSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews() {
        
        
        self.leftTitle = UILabel()
        self.leftTitle?.textColor = .black
        self.leftTitle?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.leftTitle!)
        
        self.rightTitle = UILabel()
        self.rightTitle?.textColor = TextColor_999999
        self.rightTitle?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.rightTitle!)
        
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubViews() {
        
       
        self.leftTitle?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.centerY.equalTo((self.contentView.snp.centerY))
        })
        
        self.rightTitle?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.centerY.equalTo((self.contentView.snp.centerY))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
