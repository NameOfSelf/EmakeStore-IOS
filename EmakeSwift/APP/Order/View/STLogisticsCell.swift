//
//  STLogisticsCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STLogisticsCell: UITableViewCell {
    
    var shippingNo : UILabel?
    var shippingCarNo : UILabel?
    var shippingPhone : UILabel?
    var productName : UILabel?
    var productNumber : UILabel?
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
        
        self.shippingNo = UILabel()
        self.shippingNo?.textColor = TextColor_333333
        self.shippingNo?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.shippingNo!)
        
        self.shippingCarNo = UILabel()
        self.shippingCarNo?.textColor = TextColor_333333
        self.shippingCarNo?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.shippingCarNo!)
        
        self.shippingPhone = UILabel()
        self.shippingPhone?.textColor = TextColor_333333
        self.shippingPhone?.font = AdaptFont(actureValue: 15)
        self.contentView.addSubview(self.shippingPhone!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
        
        
        self.productName = UILabel()
        self.productName?.textColor = TextColor_333333
        self.productName?.numberOfLines = 0
        self.productName?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.productName!)
        
        
        self.productNumber = UILabel()
        self.productNumber?.textColor = TextColor_999999
        self.productNumber?.numberOfLines = 0
        self.productNumber?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.productNumber!)
        
    }
    
    private func snapSubViews() {
        
        self.shippingNo?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 16))
            make.height.equalTo(HeightRate(actureValue: 21))
            make.top.equalTo(HeightRate(actureValue: 10))
        })
        
        self.shippingCarNo?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 16))
            make.height.equalTo(HeightRate(actureValue: 21))
            make.top.equalTo((self.shippingNo?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        self.shippingPhone?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.height.equalTo(HeightRate(actureValue: 21))
            make.top.equalTo((self.shippingCarNo?.snp.top)!)
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.left.equalTo(WidthRate(actureValue: 16))
            make.height.equalTo(1)
            make.top.equalTo((self.shippingPhone?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        self.productName?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 16))
            make.top.equalTo((self.line?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        self.productNumber?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.top.equalTo((self.line?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
    }
    
    func setData(model:STLogosticsModel) {
        if (model.ShippingNo?.count)! <= 0 || model.ShippingNo == nil {
            self.shippingNo?.text = "运单号："
        }else{
            self.shippingNo?.text = String(format: "运单号：%@", arguments: [model.ShippingNo!])
        }
        if (model.ShippingPlate?.count)! <= 0 || model.ShippingPlate == nil {
            self.shippingCarNo?.text = "车牌号码："
        }else{
            self.shippingCarNo?.text = String(format: "车牌号码：%@", arguments: [model.ShippingPlate!])
        }
        if (model.ShippingPhone?.count)! <= 0 || model.ShippingPhone == nil {
            self.shippingPhone?.text = "联系电话："
        }else{
            self.shippingPhone?.text = String(format: "联系电话：%@", arguments: [model.ShippingPhone!])
        }
        var shipLeftArray : [String]? = []
        var shipRightArray : [String]? = []
        if (model.Goods?.count)! > 0 {
            for ship in model.Goods! {
                if ship.GoodsReName != nil {
                    shipLeftArray?.append(ship.GoodsReName!)
                }
                if ship.ShippingNumber != nil {
                    shipRightArray?.append(String(format: "%d件", arguments: [ship.ShippingNumber!]))
                }
            }
        }
        
        self.productName?.text = shipLeftArray?.joined(separator: "\n")
        self.productNumber?.text = shipRightArray?.joined(separator: "\n")
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
