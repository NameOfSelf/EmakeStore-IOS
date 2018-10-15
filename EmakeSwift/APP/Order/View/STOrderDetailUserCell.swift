//
//  STOrderDetailUserCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/14.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STOrderDetailUserCell: UITableViewCell {
    var headImage : UIImageView?
    var nameLabel : UILabel?
    var phoneLabel :UILabel?
    var sendMessage : UIButton?
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
        
        self.headImage = UIImageView()
        self.headImage?.layer.cornerRadius = WidthRate(actureValue: 25)
        self.headImage?.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.headImage!)
        
        self.nameLabel = UILabel()
        self.nameLabel?.textColor = TextColor_333333
        self.nameLabel?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.nameLabel!)
        
        self.phoneLabel = UILabel()
        self.phoneLabel?.textColor = TextColor_333333
        self.phoneLabel?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.phoneLabel!)
        
        
        self.sendMessage = UIButton(type: .custom)
        self.sendMessage?.setTitle("发消息", for: .normal)
        self.sendMessage?.layer.cornerRadius = 3
        self.sendMessage?.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        self.sendMessage?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        self.sendMessage?.layer.borderWidth = 1;
        self.sendMessage?.titleLabel?.font = AdaptFont(actureValue: 10)
        self.contentView.addSubview(self.sendMessage!)
        
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubViews() {
        
        self.headImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.width.equalTo(HeightRate(actureValue: 37))
            make.height.equalTo(WidthRate(actureValue: 37))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.height.equalTo(HeightRate(actureValue: 19))
        })
        
        self.phoneLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo((self.nameLabel?.snp.bottom)!)
            make.height.equalTo(HeightRate(actureValue: 19))
        })
        
        self.sendMessage?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.width.equalTo(WidthRate(actureValue: 62))
            make.height.equalTo(HeightRate(actureValue: 22))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.line?.snp.makeConstraints({ (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        })
    }
    
    public func setData(model:STOrderModel){
        
        if model.HeadImageUrl == nil {
            self.headImage?.image = UIImage(named: "hehuoren-65")
        }else{
            self.headImage?.sd_setImage(with: URL(string: model.HeadImageUrl!), placeholderImage:UIImage(named: "hehuoren-65"))
        }
        if (model.RealName?.count)! <= 0 || model.RealName == nil {
            if (model.MobileNumber?.count)! <= 0 || model.MobileNumber == nil {
                self.nameLabel?.text = ""
            }else{
                self.nameLabel?.text = "用户" + model.MobileNumber![(model.MobileNumber?.count)!-4..<(model.MobileNumber?.count)!]
            }
        }else{
            self.nameLabel?.text = model.RealName
        }
        if (model.MobileNumber?.count)! <= 0 || model.MobileNumber == nil {
            self.phoneLabel?.text = ""
        }else{
            self.phoneLabel?.text = model.MobileNumber
        }
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
