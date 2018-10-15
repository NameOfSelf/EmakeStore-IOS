//
//  STOrderDetailItemBottomCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STOrderDetailItemBottomCell: UITableViewCell {
    var orderTotal : UILabel?
    var couponLabel : UILabel?
    var taxAndLogistics : UILabel?
    var line : UILabel?
    var amountRateLabel : UILabel?
    var progressLabel : UILabel?
    var amountLabel : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,orderType:OrderType) {
        
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews(orderType:orderType)
        self.snapSubViews(orderType:orderType)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews(orderType:OrderType) {
        
        
        self.couponLabel = UILabel()
        self.couponLabel?.textColor = .black
        self.couponLabel?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.couponLabel!)
        
        self.orderTotal = UILabel()
        self.orderTotal?.textColor = .black
        self.orderTotal?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.orderTotal!)
        
        self.taxAndLogistics = UILabel()
        self.taxAndLogistics?.textColor = TextColor_FF9900
        self.taxAndLogistics?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.taxAndLogistics!)
        
    
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
        
        
        self.progressLabel = UILabel()
        self.progressLabel?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        self.progressLabel?.layer.cornerRadius = 3
        self.contentView.addSubview(self.progressLabel!)
        
        
        self.amountRateLabel = UILabel()
        self.amountRateLabel?.textColor = TextColor_666666
        self.amountRateLabel?.font = AdaptFont(actureValue: 13)
        self.amountRateLabel?.layer.borderColor = TextColor_999999.cgColor
        self.amountRateLabel?.layer.borderWidth = 1
        self.amountRateLabel?.layer.cornerRadius = 5
        self.contentView.addSubview(self.amountRateLabel!)
        
        
        self.amountLabel = UILabel()
        self.amountLabel?.textColor = TextColor_666666
        self.amountLabel?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.amountLabel!)
        
    }
    
    private func snapSubViews(orderType:OrderType) {
        
        self.couponLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.top.equalTo(HeightRate(actureValue: 5))
            make.height.equalTo(HeightRate(actureValue: 19))
        })
        
        self.orderTotal?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.top.equalTo((self.couponLabel?.snp.bottom)!)
            make.height.equalTo(HeightRate(actureValue: 19))
        })
        
        self.taxAndLogistics?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.top.equalTo((self.orderTotal?.snp.bottom)!)
            make.height.equalTo(HeightRate(actureValue: 19))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo((self.taxAndLogistics?.snp.bottom)!).offset(HeightRate(actureValue: 5))
            make.height.equalTo(1)
        })
        
        self.amountRateLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.width.equalTo(WidthRate(actureValue: 250))
            make.top.equalTo((self.line?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        self.progressLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.amountRateLabel?.snp.left)!).offset(1)
            make.height.equalTo(HeightRate(actureValue: 25)-2)
            make.width.equalTo(WidthRate(actureValue: 140))
            make.top.equalTo((self.amountRateLabel?.snp.top)!).offset(1)
        })
        
        self.amountLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.amountRateLabel?.snp.left)!).offset(WidthRate(actureValue: -67))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.centerY.equalTo((self.progressLabel?.snp.centerY)!)
        })
        
    }
    public func setData(model:STOrderModel){
        
        if model.ContractQuantity == nil{
            return
        }
        if model.ContractAmount == nil{
            return
        }
        if model.HasPayFee == nil{
            return
        }
        if (model.GoodsAddValue?.count)! <= 0 || (model.GoodsAddValue == nil){
            return
        }
        let str = String(format: "共%d件商品 合计：¥%.2f", arguments: [model.ContractQuantity!,model.ContractAmount!])
        let attrStr = NSMutableAttributedString(string:str)
        let amountStr = String(format: "(%.2f)", arguments: [model.ContractAmount!])
        attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value:BaseColor.APP_THEME_MAIN_COLOR, range:NSRange.init(location:str.count-amountStr.count+1, length: amountStr.count-1))
        attrStr.addAttribute(NSAttributedStringKey.font, value:AdaptFont(actureValue: 14), range:NSRange.init(location:str.count-amountStr.count+1, length: amountStr.count-1))
        self.orderTotal?.attributedText = attrStr
        
        let strAnother = String(format: "优惠券：-¥%.2f", arguments: [model.CouponValue!])
        let attrStrAnother = NSMutableAttributedString(string:strAnother)
        let couponStr = String(format: "(%.2f)", arguments: [model.CouponValue!])
        attrStrAnother.addAttribute(NSAttributedStringKey.foregroundColor, value:TextColor_F8695D, range:NSRange.init(location:4, length: couponStr.count))
        attrStrAnother.addAttribute(NSAttributedStringKey.font, value:AdaptFont(actureValue: 14), range:NSRange.init(location:4, length: couponStr.count))
        self.couponLabel?.attributedText = attrStrAnother
        
        self.taxAndLogistics?.text = String(format: "(%@)", arguments: [model.GoodsAddValue!])
        self.amountLabel?.text = String(format: "已付金额：  %.2f/%.2f", arguments: [model.HasPayFee!,model.ContractAmount!])
        var width = CGFloat((model.HasPayFee!/model.ContractAmount!))*WidthRate(actureValue: 250)
        if CGFloat((model.HasPayFee!/model.ContractAmount!)) >= 1.0 {
            width = WidthRate(actureValue: 250)
        }
        self.progressLabel?.snp.updateConstraints({ (make) in
            make.width.equalTo(width-2)
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
