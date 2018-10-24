//
//  STOrderDetailBottomCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/14.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STOrderDetailBottomCell: UITableViewCell {

    var contractChatButton : UIButton?
    var lookUpContractButton : UIButton?
    var lookUpLogisticsButton : UIButton?
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
        
        
        self.contractChatButton = UIButton(type: .custom)
        self.contractChatButton?.setTitle("合同洽谈", for: .normal)
        self.contractChatButton?.titleLabel?.font = AdaptFont(actureValue: 10)
        self.contractChatButton?.setTitleColor(TextColor_999999, for: .normal)
        self.contractChatButton?.layer.borderColor = TextColor_999999.cgColor
        self.contractChatButton?.layer.borderWidth = 1
        self.contractChatButton?.layer.cornerRadius = 3
        self.contentView.addSubview(self.contractChatButton!)
        
        self.lookUpContractButton = UIButton(type: .custom)
        if orderType == .待签订{
            self.lookUpContractButton?.setTitle("预览合同", for: .normal)
        }else{
            self.lookUpContractButton?.setTitle("查看合同", for: .normal)
        }
        self.lookUpContractButton?.titleLabel?.font = AdaptFont(actureValue: 10)
        self.lookUpContractButton?.setTitleColor(TextColor_999999, for: .normal)
        self.lookUpContractButton?.layer.borderColor = TextColor_999999.cgColor
        self.lookUpContractButton?.layer.borderWidth = 1
        self.lookUpContractButton?.layer.cornerRadius = 3
        self.contentView.addSubview(self.lookUpContractButton!)
        
        
        self.lookUpLogisticsButton = UIButton(type: .custom)
        self.lookUpLogisticsButton?.setTitle("查看物流", for: .normal)
        self.lookUpLogisticsButton?.titleLabel?.font = AdaptFont(actureValue: 10)
        self.lookUpLogisticsButton?.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        self.lookUpLogisticsButton?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        self.lookUpLogisticsButton?.layer.borderWidth = 1
        self.lookUpLogisticsButton?.layer.cornerRadius = 3
        self.contentView.addSubview(self.lookUpLogisticsButton!)
        
        if orderType == .发货中 {
            self.lookUpLogisticsButton?.isHidden = false
            self.lookUpContractButton?.setTitleColor(TextColor_999999, for: .normal)
            self.lookUpContractButton?.layer.borderColor = TextColor_999999.cgColor
        }else{
            self.lookUpLogisticsButton?.isHidden = true
            self.lookUpContractButton?.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
            self.lookUpContractButton?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        }
    }
    
    private func snapSubViews(orderType:OrderType) {
        
        self.lookUpLogisticsButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.height.equalTo(HeightRate(actureValue: 22))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(HeightRate(actureValue: 70))
        })
        
        self.lookUpContractButton?.snp.makeConstraints({ (make) in
           if orderType == .发货中 { make.right.equalTo((self.lookUpLogisticsButton?.snp.left)!).offset(WidthRate(actureValue: -10))
           }else{
                make.right.equalTo(WidthRate(actureValue: -12))
            }
            make.height.equalTo(HeightRate(actureValue: 22))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(HeightRate(actureValue: 70))
        })
        
        self.contractChatButton?.snp.makeConstraints({ (make) in
            make.right.equalTo((self.lookUpContractButton?.snp.left)!).offset(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 22))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(HeightRate(actureValue: 70))
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
