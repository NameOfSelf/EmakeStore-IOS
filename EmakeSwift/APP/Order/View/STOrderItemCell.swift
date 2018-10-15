//
//  STOrderItemCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STOrderItemCell: UITableViewCell {

    var productImage : UIImageView?
    var productName : UILabel?
    var productDescriptions : UILabel?
    var productCount : UILabel?
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
        
        
        self.productCount = UILabel()
        self.productCount?.textColor = TextColor_A1A1A1
        self.productCount?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.productCount!)
        
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    
    private func snapSubViews() {
        
        self.productImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 12))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.width.equalTo(WidthRate(actureValue: 70))
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
            make.height.greaterThanOrEqualTo(HeightRate(actureValue: 60))
        })
        
        self.productCount?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 22))
            make.bottom.equalTo(HeightRate(actureValue: -11))
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
        self.productName?.text = model.GoodsTitle
        self.productDescriptions?.text = model.GoodsExplain
        self.productCount?.text = String(format: "X%d", arguments: [model.GoodsNumber!])
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
