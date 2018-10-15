//
//  STMineTableViewCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/10.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
enum MineCellType{
    
    case RightWithImage,RightWithText,RightNone
}
class STMineTableViewCell: UITableViewCell {
    var leftImage : UIImageView?
    var leftTitle : UILabel?
    var rightTitle : UILabel?
    var rightImage : UIImageView?
    var line : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,type:MineCellType) {
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews(type:type)
        self.snapSubviews(type:type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configSubViews(type:MineCellType) {
        
        self.leftImage = UIImageView()
        self.contentView.addSubview(self.leftImage!)
        
        self.leftTitle = UILabel()
        self.leftTitle?.textColor = TextColor_333333
        self.leftTitle?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.leftTitle!)
        
        self.rightTitle = UILabel()
        self.rightTitle?.textColor = TextColor_999999
        self.rightTitle?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.rightTitle!)
        
        self.rightImage = UIImageView(image: UIImage(named: "direction_right"))
        self.contentView.addSubview(self.rightImage!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubviews(type:MineCellType) {
        
        self.leftImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 14))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(WidthRate(actureValue: 25))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.leftTitle?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.leftImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.height.equalTo(WidthRate(actureValue: 21))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
        })
        
        switch type {
        case .RightWithImage:
            self.rightImage?.snp.makeConstraints({ (make) in
                make.right.equalTo(WidthRate(actureValue: -12))
                make.width.equalTo(WidthRate(actureValue: 15))
                make.height.equalTo(WidthRate(actureValue: 15))
                make.centerY.equalTo(self.contentView.snp.centerY)
            })
            self.rightTitle?.isHidden = true
        case .RightWithText:
            self.rightTitle?.snp.makeConstraints({ (make) in
                make.right.equalTo(WidthRate(actureValue: -12))
                make.height.equalTo(WidthRate(actureValue: 21))
                make.centerY.equalTo(self.contentView.snp.centerY)
            })
            self.rightImage?.isHidden = true
        default:
            self.rightImage?.isHidden = true
            self.rightTitle?.isHidden = true
        }
    }
    
    public func setData(data:NSData){
        
    }
    
}
