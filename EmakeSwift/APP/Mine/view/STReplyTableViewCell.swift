//
//  STReplyTableViewCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/17.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STReplyTableViewCell: UITableViewCell {

    var titleLabel : UILabel?
    var timeLabel : UILabel?
    var switchIsOn : UISwitch?
    var line : UILabel?
    var contentLabel : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snapSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews() {
        
        self.titleLabel = UILabel()
        self.titleLabel?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.titleLabel!)
        
        self.timeLabel = UILabel()
        self.timeLabel?.font = AdaptFont(actureValue: 12)
        self.timeLabel?.textColor = TextColor_999999
        self.contentView.addSubview(self.timeLabel!)
        
        self.switchIsOn = UISwitch()
        self.switchIsOn?.isOn = false
        self.contentView.addSubview(self.switchIsOn!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
        
        self.contentLabel = UILabel()
        self.contentLabel?.font = AdaptFont(actureValue: 12)
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.textColor = TextColor_999999
        self.contentView.addSubview(self.contentLabel!)
        
    }
    
    private func snapSubViews() {
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 10))
            make.top.equalTo(HeightRate(actureValue: 10))
        })
        
        self.timeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.titleLabel?.snp.right)!).offset(WidthRate(actureValue: 3))
            make.centerY.equalTo((self.titleLabel?.snp.centerY)!)
        })
        
        self.switchIsOn?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -19))
            make.top.equalTo(HeightRate(actureValue: 10))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.right.equalTo(0)
            make.height.equalTo(1)
        })
        
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.line?.snp.bottom)!).offset(HeightRate(actureValue: 10))
            make.left.equalTo(WidthRate(actureValue: 10))
            make.right.equalTo(WidthRate(actureValue: -15))
        })
    }
    
    public func setData(model:STReplyModel) {
        
        self.titleLabel?.text = ""
        
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
