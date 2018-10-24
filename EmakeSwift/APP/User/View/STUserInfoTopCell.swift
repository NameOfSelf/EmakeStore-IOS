//
//  STUserInfoTopCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STUserInfoTopCell: UITableViewCell {

    var headImage : UIImageView?
    var identityImage : UIImageView?
    var nameLabel : UILabel?
    var orderCountLabel :UILabel?
    var orderAmountLabel : UILabel?
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
        self.headImage?.layer.cornerRadius = WidthRate(actureValue: 40)
        self.headImage?.clipsToBounds = true
        self.headImage?.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.headImage!)
        
        self.identityImage = UIImageView()
        self.identityImage?.layer.cornerRadius = WidthRate(actureValue: 12)
        self.identityImage?.contentMode = .scaleAspectFit
        self.identityImage?.clipsToBounds = true
        self.contentView.addSubview(self.identityImage!)
        
        self.nameLabel = UILabel()
        self.nameLabel?.textColor = TextColor_333333
        self.nameLabel?.font = AdaptFont(actureValue: 16)
        self.contentView.addSubview(self.nameLabel!)
        
        self.orderCountLabel = UILabel()
        self.orderCountLabel?.textColor = TextColor_999999
        self.orderCountLabel?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.orderCountLabel!)
        
        self.orderAmountLabel = UILabel()
        self.orderAmountLabel?.textColor = TextColor_999999
        self.orderAmountLabel?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.orderAmountLabel!)
        
        self.sendMessage = UIButton(type: .custom)
        self.sendMessage?.setTitle("发消息", for: .normal)
        self.sendMessage?.layer.cornerRadius = 3
        self.sendMessage?.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        self.sendMessage?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        self.sendMessage?.layer.borderWidth = 1;
        self.sendMessage?.titleLabel?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.sendMessage!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubViews() {
        
        self.headImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.width.equalTo(HeightRate(actureValue: 80))
            make.height.equalTo(WidthRate(actureValue: 80))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.identityImage?.snp.makeConstraints({ (make) in
            make.centerX.equalTo((self.headImage?.snp.centerX)!).offset(WidthRate(actureValue: 28))
            make.width.equalTo(HeightRate(actureValue: 24))
            make.height.equalTo(WidthRate(actureValue: 24))
            make.centerY.equalTo((self.headImage?.snp.centerY)!).offset(WidthRate(actureValue: 28))
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 11))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.height.equalTo(HeightRate(actureValue: 25))
        })
        
        self.orderAmountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 11))
            make.centerY.equalTo((self.contentView.snp.centerY))
            make.height.equalTo(HeightRate(actureValue: 25))
        })
        
        self.orderCountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 11))
            make.top.equalTo((self.orderAmountLabel?.snp.bottom)!).offset(HeightRate(actureValue: 4))
            make.height.equalTo(HeightRate(actureValue: 25))
        })
        
        self.sendMessage?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.width.equalTo(WidthRate(actureValue: 62))
            make.height.equalTo(HeightRate(actureValue: 28))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        })
    }
    
    public func setData(model:STUserModel,isVip:Bool) {
        
        self.headImage?.sd_setImage(with: URL(string: model.HeadImageUrl ?? ""), placeholderImage: UIImage(named: "yonghuyouxiangL"))
        if model.UserIdentity == "2"{
            self.identityImage?.image = UIImage(named: "huiyuanbiaozhi")
            self.identityImage?.isHidden = false
        }else if model.UserIdentity == "3"{
            self.identityImage?.image = UIImage(named: "huiyuanbiaozhi")
            self.identityImage?.isHidden = false
        }else if model.UserIdentity == "0"{
            self.identityImage?.isHidden = true
        }else if model.UserIdentity == "1"{
            self.identityImage?.image = UIImage(named: "dailishangbiaozhi")
            self.identityImage?.isHidden = false
        }
        if model.NickName == nil || model.NickName?.count == 0{
            if model.RealName == nil || model.RealName?.count == 0{
                self.nameLabel?.text = "用户" + model.MobileNumber![(model.MobileNumber?.count)!-4..<(model.MobileNumber?.count)!]
            }else{
                self.nameLabel?.text = model.RealName
            }
        }else{
            self.nameLabel?.text = model.NickName
        }
        var TotalQuantity = 0
        var TotalAmount = 0.0
        if model.TotalQuantity != nil {
            TotalQuantity = model.TotalOrders!
        }
        if model.TotalAmount != nil {
            TotalAmount = model.TotalAmount!
        }
        if model.TotalQuantity == nil {
            self.orderCountLabel?.text = "订单数：0"
        }else{
            self.orderCountLabel?.text = "订单数：\(TotalQuantity)"
        }
        if model.TotalAmount == nil {
            self.orderAmountLabel?.text = "订单总金额：¥0.00"
        }else{
            self.orderAmountLabel?.text = "订单总金额：¥\(TotalAmount)"
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
