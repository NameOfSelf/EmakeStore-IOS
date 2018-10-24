//
//  STUserInfoOrderCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STUserInfoOrderCell: UITableViewCell {

    var orderNoLabel : UILabel?
    var dateLabel : UILabel?
    var orderStateLabel : UILabel?
    var amountLabel : UILabel?
    var line : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snapSubViews()
    }
    private func configSubViews() {
        
        
        self.orderNoLabel = UILabel()
        self.orderNoLabel?.textColor = TextColor_333333
        self.orderNoLabel?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.orderNoLabel!)
        
        self.dateLabel = UILabel()
        self.dateLabel?.textColor = TextColor_999999
        self.dateLabel?.font = AdaptFont(actureValue: 10)
        self.contentView.addSubview(self.dateLabel!)
        
        self.orderStateLabel = UILabel()
        self.orderStateLabel?.textColor = BaseColor.APP_THEME_MAIN_COLOR
        self.orderStateLabel?.layer.cornerRadius = 2
        self.orderStateLabel?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        self.orderStateLabel?.layer.borderWidth = 1
        self.orderStateLabel?.textAlignment = .center
        self.orderStateLabel?.font = AdaptFont(actureValue: 10)
        self.contentView.addSubview(self.orderStateLabel!)
        
        
        self.amountLabel = UILabel()
        self.amountLabel?.textColor = TextColor_333333
        self.amountLabel?.font = AdaptFont(actureValue: 16)
        self.contentView.addSubview(self.amountLabel!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubViews() {
        
        
        self.orderNoLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.height.equalTo(HeightRate(actureValue: 28))
        })
        
        self.dateLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.top.equalTo((self.orderNoLabel?.snp.bottom)!).offset(HeightRate(actureValue: 3))
            make.height.equalTo(HeightRate(actureValue: 28))
        })
        
        self.orderStateLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.orderNoLabel?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.centerY.equalTo((self.orderNoLabel?.snp.centerY)!)
            make.height.equalTo(HeightRate(actureValue: 17))
            make.width.equalTo(WidthRate(actureValue: 45))
        })
        
        self.amountLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 28))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        })
        
    }
    public func setData(model:STUserOrderModel) {
        
        self.orderNoLabel?.text = "订单号：\(model.ContractNo as! String)"
        if model.OrderState == "0"{
            self.orderStateLabel?.text = "待付款"
        }else if model.OrderState == "1"{
            self.orderStateLabel?.text = "生产中"
        }else if model.OrderState == "2"{
            self.orderStateLabel?.text = "生产完成"
        }else if model.OrderState == "3"{
            self.orderStateLabel?.text = "发货中"
        }else if model.OrderState == "-2"{
            self.orderStateLabel?.text = "待签订"
        }
        self.dateLabel?.text = model.InDate
        if model.ContractAmount == nil {
            self.amountLabel?.text = ""
        }else{
            self.amountLabel?.text = String(format: "¥%.2f", arguments: [model.ContractAmount!])
        }
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

}
