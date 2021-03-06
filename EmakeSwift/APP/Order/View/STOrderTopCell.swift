//
//  STOrderTopCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STOrderTopCell: UITableViewCell {

    var orderNoLabel : UILabel? 
    var orderStateLabel : UILabel?
    var taxLabel : UILabel?
    var superGroupLabel : UILabel?
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
    
        self.orderNoLabel = UILabel()
        self.orderNoLabel?.textColor = TextColor_333333
        self.orderNoLabel?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.orderNoLabel!)
    
        
        self.orderStateLabel = UILabel()
        self.orderStateLabel?.textColor = BaseColor.APP_THEME_MAIN_COLOR
        self.orderStateLabel?.font = AdaptFont(actureValue: 10)
        self.contentView.addSubview(self.orderStateLabel!)
        
        
        self.taxLabel = UILabel()
        self.taxLabel?.textColor = .white
        self.taxLabel?.text = "含税"
        self.taxLabel?.textAlignment = .center
        self.taxLabel?.backgroundColor = TextColor_FFCC00
        self.taxLabel?.font = AdaptFont(actureValue: 8)
        self.contentView.addSubview(self.taxLabel!)
        
        self.superGroupLabel = UILabel()
        self.superGroupLabel?.textColor = .white
        self.superGroupLabel?.text = "超级团"
        self.superGroupLabel?.textAlignment = .center
        self.superGroupLabel?.backgroundColor = TextColor_F8695D
        self.superGroupLabel?.font = AdaptFont(actureValue: 8)
        self.contentView.addSubview(self.superGroupLabel!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubViews() {
        
        
        self.orderNoLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.taxLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.orderNoLabel?.snp.right)!).offset(WidthRate(actureValue: 2))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 14))
            make.width.equalTo(WidthRate(actureValue: 26))
        })
        
        self.superGroupLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.taxLabel?.snp.right)!).offset(WidthRate(actureValue: 5))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 14))
            make.width.equalTo(WidthRate(actureValue: 30))
        })
        
        self.orderStateLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
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
        
        self.orderNoLabel?.text = "合同号：\(model.ContractNo!)"
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
        if model.IsIncludeTax == "1" {
            self.taxLabel?.isHidden = false
        }else{
            self.taxLabel?.isHidden = true
        }
        if model.SuperGroupDetailId == nil || model.SuperGroupDetailId?.count == 0{
            self.superGroupLabel?.isHidden = true
        }else{
            self.superGroupLabel?.isHidden = false
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
