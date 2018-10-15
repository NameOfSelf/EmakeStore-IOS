//
//  STMessageOrderItemCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/8.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STMessageOrderItemCell: UITableViewCell {

    var productImage : UIImageView?
    var productName : UILabel?
    var productDescriptions : UILabel?
    var productPrice : UILabel?
    var line : UILabel?
    var addServersLabel : UILabel?
    var serverLabelLeft : UILabel?
    var serverLabelRight : UILabel?
    var addBrandLabel : UILabel?
    var brandLabelLeft : UILabel?
    var brandLabellRight : UILabel?
    var lineAnother : UILabel?
    var lineBottom : UILabel?
    var productCount : UILabel?
    var productTotalPrice : UILabel?
    var shippingFee : UILabel?
    var protocolButton : UIButton?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snapSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configSubViews() {
        
        self.productImage = UIImageView()
        self.productImage?.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.productImage!)
        
        
        self.productName = UILabel()
        self.productName?.textColor = TextColor_333333
        self.productName?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.productName!)
        
        
        self.productDescriptions = UILabel()
        self.productDescriptions?.textColor = TextColor_A1A1A1
        self.productDescriptions?.font = AdaptFont(actureValue: 13)
        self.productDescriptions?.numberOfLines = 0
        self.contentView.addSubview(self.productDescriptions!)
        
        
        self.productPrice = UILabel()
        self.productPrice?.textColor = TextColor_A1A1A1
        self.productPrice?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.productPrice!)
        
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
        
        
        self.addServersLabel = UILabel()
        self.addServersLabel?.textColor = TextColor_333333
        self.addServersLabel?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.addServersLabel!)
        
        
        self.serverLabelLeft = UILabel()
        self.serverLabelLeft?.numberOfLines = 0
        self.serverLabelLeft?.textColor = TextColor_333333
        self.serverLabelLeft?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.serverLabelLeft!)
        
        
        self.serverLabelRight = UILabel()
        self.serverLabelRight?.numberOfLines = 0
        self.serverLabelRight?.textColor = TextColor_A1A1A1
        self.serverLabelRight?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.serverLabelRight!)
        
        self.addBrandLabel = UILabel()
        self.addBrandLabel?.textColor = TextColor_333333
        self.addBrandLabel?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.addBrandLabel!)
        
        
        self.brandLabelLeft = UILabel()
        self.brandLabelLeft?.numberOfLines = 0
        self.brandLabelLeft?.textColor = TextColor_333333
        self.brandLabelLeft?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.brandLabelLeft!)
        
        
        self.brandLabellRight = UILabel()
        self.brandLabellRight?.numberOfLines = 0
        self.brandLabellRight?.textColor = TextColor_A1A1A1
        self.brandLabellRight?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.brandLabellRight!)
        
        
        self.lineAnother = UILabel()
        self.lineAnother?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.lineAnother!)
        
        
        self.productCount = UILabel()
        self.productCount?.textColor = TextColor_A1A1A1
        self.productCount?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.productCount!)
        
        
        self.productTotalPrice = UILabel()
        self.productTotalPrice?.textColor = .black
        self.productTotalPrice?.font = AdaptFont(actureValue: 14)
        self.contentView.addSubview(self.productTotalPrice!)
        
        
        self.shippingFee = UILabel()
        self.shippingFee?.textColor = .black
        self.shippingFee?.font = AdaptFont(actureValue: 12)
        self.contentView.addSubview(self.shippingFee!)
        
        
        self.protocolButton = UIButton(type: .custom)
        self.protocolButton?.setTitle("技术协议", for: .normal)
        self.protocolButton?.titleLabel?.font = AdaptFont(actureValue: 12)
        self.protocolButton?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        self.protocolButton?.layer.borderWidth = 1
        self.protocolButton?.layer.cornerRadius = HeightRate(actureValue: 15)
        self.protocolButton?.setImage(UIImage(named: "fasong02"), for: .normal)
        self.protocolButton?.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthRate(actureValue: 7))
        self.protocolButton?.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        self.contentView.addSubview(self.protocolButton!)
        
        
        self.lineBottom = UILabel()
        self.lineBottom?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.lineBottom!)
    }
    
    private func snapSubViews() {
        
        self.productImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.width.equalTo(WidthRate(actureValue: 80))
            make.height.equalTo(WidthRate(actureValue: 70))
        })
        
        self.productName?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.productImage?.snp.right)!).offset(WidthRate(actureValue: 2))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.height.equalTo(HeightRate(actureValue: 22))
        })
        
        self.productDescriptions?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.productImage?.snp.right)!).offset(WidthRate(actureValue: 2))
            make.top.equalTo((self.productName?.snp.bottom)!)
            make.width.equalTo(WidthRate(actureValue: 180))
            make.height.greaterThanOrEqualTo(HeightRate(actureValue: 45))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(1)
            make.top.equalTo((self.productDescriptions?.snp.bottom)!).offset(HeightRate(actureValue:10))
        })
        
        self.productPrice?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 22))
            make.bottom.equalTo((self.line?.snp.top)!).offset(HeightRate(actureValue: -2))
        })
        
        
        self.addServersLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.top.equalTo((self.line?.snp.bottom)!).offset(HeightRate(actureValue: 5))
        })
        
        self.serverLabelLeft?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.addServersLabel?.snp.right)!).offset(WidthRate(actureValue: 2))
            make.top.equalTo((self.addServersLabel?.snp.top)!)
        })
        
        self.serverLabelRight?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
            make.top.equalTo((self.addServersLabel?.snp.top)!)
        })
        
        self.addBrandLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.top.equalTo((self.serverLabelLeft?.snp.bottom)!)
        })
        
        self.brandLabelLeft?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.addBrandLabel?.snp.right)!).offset(WidthRate(actureValue: 2))
            make.top.equalTo((self.addBrandLabel?.snp.top)!)
        })
        
        self.brandLabellRight?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
            make.top.equalTo((self.addBrandLabel?.snp.top)!)
        })
        
        self.lineAnother?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(1)
            make.top.equalTo((self.brandLabelLeft?.snp.bottom)!).offset(HeightRate(actureValue:5))
        })
        
        
        self.productCount?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.lineAnother?.snp.bottom)!).offset(HeightRate(actureValue: 2))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 17))
        })
        
        
        self.productTotalPrice?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.productCount?.snp.bottom)!).offset(HeightRate(actureValue: 2))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 17))
        })
        
        self.shippingFee?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.productTotalPrice?.snp.bottom)!).offset(HeightRate(actureValue: 2))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 17))
        })
        
        self.protocolButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.width.equalTo(WidthRate(actureValue: 97))
            make.height.equalTo(HeightRate(actureValue: 30))
            make.bottom.equalTo(HeightRate(actureValue: -10))
        })
        
        self.lineBottom?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
        })
        
    }
    public func setData(model:ProductModel){
        
        if model.GoodsSeriesPhotos != nil{
            let data = model.GoodsSeriesPhotos?.data(using: .utf8)
            do {
                let jsonObj:[String] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String]
                self.productImage?.sd_setImage(with: URL(string: jsonObj[0]), placeholderImage: nil)
                
            }catch {
                
            }
        }
        if (model.AddServiceInfo?.count)! <= 0{
            self.addServersLabel?.isHidden = true
            self.lineAnother?.isHidden = true
        }else{
            self.addServersLabel?.isHidden = false
            self.lineAnother?.isHidden = false
        }
        self.productName?.text = model.GoodsTitle
        self.productDescriptions?.text = model.GoodsExplain
        var serverLeftArray : [String]? = []
        var brandLeftArray : [String]? = []
        var serverRightArray : [String]? = []
        var brandRightArray : [String]? = []
        for serverInfo in model.AddServiceInfo! {
            if serverInfo.GoodsType == "2"{
                self.addServersLabel?.text = serverInfo.GoodsTypeName! + "："
                serverLeftArray?.append(serverInfo.GoodsTitle!)
                serverRightArray?.append((serverInfo.GoodsPrice?.description)!)
            }else if serverInfo.GoodsType == "3"{
                self.addBrandLabel?.text = serverInfo.GoodsTypeName! + "："
                brandLeftArray?.append(serverInfo.GoodsTitle!)
                brandRightArray?.append((serverInfo.GoodsPrice?.description)!)
            }
        }
        self.productPrice?.text = String(format: "¥%.2f",arguments: [model.MainProductPrice!])
        self.serverLabelLeft?.text = serverLeftArray?.joined(separator: "\n")
        self.serverLabelRight?.text = serverRightArray?.joined(separator: "\n")
        self.brandLabelLeft?.text = brandLeftArray?.joined(separator: "\n")
        self.brandLabellRight?.text = brandRightArray?.joined(separator: "\n")
        self.productCount?.text = String(format: "X%d", arguments:[model.GoodsNumber!])
        self.productTotalPrice?.text = String(format: "小计：%.2f",arguments: [model.ProductGroupPrice!])
        self.shippingFee?.text = String(format: "运费：%.2f", arguments:[model.TotalShippingFee!])
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

