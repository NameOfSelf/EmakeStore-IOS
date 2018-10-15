//
//  STOrderDetailTopCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/14.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STOrderDetailTopCell: UITableViewCell {
    
    var statusBackgroundImageView: UIImageView?
    var statusImageView: UIImageView?
    var statusLabel : UILabel?
    var statusMoreLabel : UILabel?
    var orderView : UIView?
    var orderNoLabel : UILabel?
    var dateLabel : UILabel?
    var taxLabel : UILabel?
    var addressView : UIView?
    var addressImageView : UIImageView?
    var addressName : UILabel?
    var addressPhone : UILabel?
    var addressLabel : UILabel?
    
    
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
        
        
        self.statusBackgroundImageView = UIImageView(image: UIImage(named: "h64"))
        self.contentView.addSubview(self.statusBackgroundImageView!)
        
        
        self.statusImageView = UIImageView()
        self.contentView.addSubview(self.statusImageView!)
        
        self.statusLabel = UILabel()
        self.statusLabel?.textColor = .white
        self.statusLabel?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.statusLabel!)
        
        
        self.statusMoreLabel = UILabel()
        self.statusMoreLabel?.textColor = .white
        self.statusMoreLabel?.font = AdaptFont(actureValue: 10)
        self.contentView.addSubview(self.statusMoreLabel!)
        
        
        switch orderType {
        case .已发货:
            self.statusImageView?.image = UIImage(named: "icon_order_status_ deliver")
            self.statusLabel?.text = "已发货"
            self.statusMoreLabel?.text = "订单已发货，请耐心等待"
        case .待签订:
            self.statusImageView?.image = UIImage(named: "icon_order_status_Contract_not_yet_signed")
            self.statusLabel?.text = "待签订"
            self.statusMoreLabel?.text = "订单还签订合同，尽快付款"
        case .生产中:
            self.statusImageView?.image = UIImage(named: "icon_order_status_In_Production")
            self.statusLabel?.text = "生产中"
            self.statusMoreLabel?.text = "订单正在生产中，请耐心等待"
        case .生产完成:
            self.statusImageView?.image = UIImage(named: "icon_order_status_production_completion")
            self.statusLabel?.text = "生产完成"
            self.statusMoreLabel?.text = "订单已生产完成，请耐心等待"
        default:
            self.statusImageView?.image = UIImage(named: "icon_order_status_obligation")
            self.statusLabel?.text = "待付款"
            self.statusMoreLabel?.text = "订单还未付款，请l提醒客户尽快付款"
        }
        
        self.orderView = UIView()
        self.orderView?.backgroundColor = BaseColor.BackgroundColor
        self.contentView.addSubview(self.orderView!)
        
        self.orderNoLabel = UILabel()
        self.orderNoLabel?.textColor = TextColor_333333
        self.orderNoLabel?.font = AdaptFont(actureValue: 12)
        self.orderView?.addSubview(self.orderNoLabel!)
        
        self.taxLabel = UILabel()
        self.taxLabel?.textColor = .white
        self.taxLabel?.text = "含税"
        self.taxLabel?.textAlignment = .center
        self.taxLabel?.backgroundColor = TextColor_FFCC00
        self.taxLabel?.font = AdaptFont(actureValue: 6)
        self.orderView?.addSubview(self.taxLabel!)
        
        
        self.dateLabel = UILabel()
        self.dateLabel?.textColor = TextColor_666666
        self.dateLabel?.font = AdaptFont(actureValue: 10)
        self.orderView?.addSubview(self.dateLabel!)
        
        self.addressView = UIView()
        self.addressView?.backgroundColor = .white
        self.contentView.addSubview(self.addressView!)
        
        
        self.addressImageView = UIImageView(image: UIImage(named: "icon_order_status_address"))
        self.addressView?.addSubview(self.addressImageView!)
        
        self.addressName = UILabel()
        self.addressName?.textColor = TextColor_333333
        self.addressName?.font = AdaptFont(actureValue: 12)
        self.addressView?.addSubview(self.addressName!)
        
        self.addressPhone = UILabel()
        self.addressPhone?.textColor = TextColor_333333
        self.addressPhone?.font = AdaptFont(actureValue: 12)
        self.addressView?.addSubview(self.addressPhone!)
        
        
        self.addressLabel = UILabel()
        self.addressLabel?.textColor = TextColor_333333
        self.addressLabel?.numberOfLines = 2
        self.addressLabel?.font = AdaptFont(actureValue: 12)
        self.addressView?.addSubview(self.addressLabel!)
    }
    
    private func snapSubViews(orderType:OrderType) {
        
        self.statusBackgroundImageView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(HeightRate(actureValue: 78))
        })
        
        self.statusImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 25))
            make.width.equalTo(WidthRate(actureValue: 40))
            make.height.equalTo(WidthRate(actureValue: 40))
            make.centerY.equalTo((self.statusBackgroundImageView?.snp.centerY)!)
        })
        
        self.statusLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.statusImageView?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo(HeightRate(actureValue: 19))
            make.height.equalTo(HeightRate(actureValue: 23))
        })
        
        self.statusMoreLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.statusImageView?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo((self.statusLabel?.snp.bottom)!)
            make.height.equalTo(HeightRate(actureValue: 17))
        })
        
        self.orderView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo((self.statusBackgroundImageView?.snp.bottom)!)
            make.height.equalTo(HeightRate(actureValue: 35))
        })
        
        self.orderNoLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.centerY.equalTo((self.orderView?.snp.centerY)!)
        })
        
        self.taxLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.orderNoLabel?.snp.right)!).offset(WidthRate(actureValue: 2))
            make.centerY.equalTo((self.orderView?.snp.centerY)!)
            make.height.equalTo(HeightRate(actureValue: 12))
            make.width.equalTo(WidthRate(actureValue: 22))
        })
        
        self.dateLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
            make.centerY.equalTo((self.orderView?.snp.centerY)!)
        })
        
        self.addressView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.top.equalTo((self.orderView?.snp.bottom)!)
            make.height.equalTo(HeightRate(actureValue: 73))
        })
        
        self.addressImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.width.equalTo(WidthRate(actureValue: 20))
            make.height.equalTo(WidthRate(actureValue: 20))
            make.top.equalTo(HeightRate(actureValue: 10))
        })
        
        self.addressName?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.addressImageView?.snp.right)!).offset(WidthRate(actureValue: 3))
            make.height.equalTo(WidthRate(actureValue: 20))
            make.centerY.equalTo((self.addressImageView?.snp.centerY)!)
        })
        
        self.addressPhone?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.addressName?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.height.equalTo(WidthRate(actureValue: 20))
            make.centerY.equalTo((self.addressImageView?.snp.centerY)!)
        })
        
        self.addressLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.addressName?.snp.left)!)
            make.height.equalTo(WidthRate(actureValue: 20))
            make.top.equalTo((self.addressImageView?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
    }
    public func setData(model:STOrderModel){
        
        self.orderNoLabel?.text = "订单号：\(model.ContractNo!)"
        if model.IsIncludeTax == "1" {
            self.taxLabel?.isHidden = false
        }else{
            self.taxLabel?.isHidden = true
        }
        self.dateLabel?.text = model.InDate
        if model.Address == nil {
            self.addressView?.isHidden = true
        }else{
            self.addressView?.isHidden = false
        }
        let adressModel = Mapper<AddressModel>().map(JSONString: model.Address!)
        self.addressName?.text = adressModel?.UserName
        self.addressPhone?.text = adressModel?.MobileNumber
        self.addressLabel?.text = adressModel?.Address
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
