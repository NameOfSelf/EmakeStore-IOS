//
//  MessageEventCollectionViewCell.swift
//  sample
//
//  Created by oshumini on 2017/6/16.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import ObjectMapper
class MessageEventCollectionViewCell: UICollectionViewCell {
    var timeView : UILabel?
    var backView : UIView?
    var title : UILabel?
    var line : UILabel?
    var orderNoLabel : UILabel?
    var itemImage : UIImageView?
    var itemName : UILabel?
    var itemParameter : UILabel?
    var priceLabel : UILabel?
    var downImage : UIImageView?
    var eventText : String?
    var lineAnother : UILabel?
    weak var delegate : MessageEventCellDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configSubViews()
    }
    
    private func configSubViews(){
        
        self.timeView = UILabel()
        self.timeView?.backgroundColor = .clear
        self.timeView?.textColor = TextColor_90A6C4
        self.timeView?.font = AdaptFont(actureValue: 12)
        self.timeView?.textAlignment = .center
        self.contentView.addSubview(self.timeView!)
        
        self.timeView?.snp.makeConstraints({ (make) in
            make.top.equalTo(HeightRate(actureValue: 15))
            make.height.equalTo(10)
            make.width.equalTo(ScreenWidth)
            make.centerX.equalTo(self.contentView.snp.centerX)
        })
        
        
        self.backView = UIView()
        self.backView?.backgroundColor = .white
        self.backView?.layer.borderWidth = WidthRate(actureValue: 2)
        self.backView?.layer.borderColor = BaseColor.SepratorLineColor.cgColor
        self.backView?.layer.cornerRadius = WidthRate(actureValue: 5)
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tapBubble))
        self.backView?.addGestureRecognizer(gesture)
        self.contentView.addSubview(self.backView!)
        
        self.backView?.snp.makeConstraints({ (make) in
            make.top.equalTo(HeightRate(actureValue: 30))
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.bottom.equalTo(0)
            make.width.equalTo(ScreenWidth)
        })
        
        self.title = UILabel()
        self.title?.text = "订单信息"
        self.title?.font = AdaptFont(actureValue: 14)
        self.title?.textColor = TextColor_666666
        self.backView?.addSubview(self.title!)
        
        self.title?.snp.makeConstraints({ (make) in
            if ScreenWidth == 320 {
                make.left.equalTo(20)
            }else {
                make.left.equalTo(WidthRate(actureValue: 15))
            }
            make.height.equalTo(HeightRate(actureValue: 18))
            make.top.equalTo(HeightRate(actureValue: 10))
        })
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.backView?.addSubview(self.line!)
        
        self.line?.snp.makeConstraints({ (make) in
            if ScreenWidth == 320 {
                make.left.equalTo(20)
            }else {
                make.left.equalTo(WidthRate(actureValue: 15))
            }
            make.right.equalTo(WidthRate(actureValue: -15))
            make.height.equalTo(1.5)
            make.top.equalTo((self.title?.snp.bottom)!).offset(HeightRate(actureValue: 4))
        })
        
        self.orderNoLabel = UILabel()
        self.orderNoLabel?.textColor = TextColor_999999
        self.orderNoLabel?.font = AdaptFont(actureValue: 13)
        self.backView?.addSubview(self.orderNoLabel!)
        
        self.orderNoLabel?.snp.makeConstraints({ (make) in
            if ScreenWidth == 320 {
                make.left.equalTo(20)
            }else {
                make.left.equalTo(WidthRate(actureValue: 15))
            }
            make.height.equalTo(HeightRate(actureValue: 18))
            make.top.equalTo((self.line?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        
        self.itemImage = UIImageView()
        self.itemImage?.layer.borderColor = BaseColor.SepratorLineColor.cgColor
        self.itemImage?.layer.borderWidth = 1.5
        self.backView?.addSubview(self.itemImage!)
        
        
        self.itemImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 15))
            make.height.equalTo(HeightRate(actureValue: 70))
            make.width.equalTo(WidthRate(actureValue: 75))
            make.top.equalTo((orderNoLabel?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        
        self.itemName = UILabel()
        self.itemName?.font = AdaptFont(actureValue: 15)
        self.itemName?.textColor = .black
        self.itemName?.numberOfLines = 0
        self.backView?.addSubview(self.itemName!)
        
        self.itemName?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.itemImage?.snp.right)!).offset(HeightRate(actureValue: 10))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.top.equalTo((self.orderNoLabel?.snp.bottom)!).offset(HeightRate(actureValue: 10))
        })
        
        self.itemParameter = UILabel()
        self.itemParameter?.font = AdaptFont(actureValue: 15)
        self.itemParameter?.textColor = TextColor_666666
        self.itemParameter?.numberOfLines = 0
        self.backView?.addSubview(self.itemParameter!)
        
        self.itemParameter?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.itemImage?.snp.right)!).offset(HeightRate(actureValue: 10))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.top.equalTo((self.itemName?.snp.bottom)!).offset(HeightRate(actureValue: 5))
        })
        
        self.priceLabel = UILabel()
        self.priceLabel?.font = AdaptFont(actureValue: 15)
        self.priceLabel?.textColor = TextColor_666666
        self.priceLabel?.numberOfLines = 0
        self.backView?.addSubview(self.priceLabel!)
        
        self.priceLabel?.snp.makeConstraints({ (make) in
            make.height.equalTo(HeightRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: -20))
            make.bottom.equalTo(HeightRate(actureValue: -30))
        })
        
        self.downImage = UIImageView(image: UIImage(named: "direction_down"))
        self.backView?.addSubview(self.downImage!)
        
        
        self.downImage?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.height.equalTo(HeightRate(actureValue: 14))
            make.width.equalTo(WidthRate(actureValue: 14))
            make.bottom.equalTo(HeightRate(actureValue: -5))
        })
    }
  
    func presentCell(eventText: String) {
        self.eventText = eventText
        let model = Mapper<MessageOrderModel>().map(JSONString: eventText)
        self.itemName?.text = model?.GoodsTitle ?? ""
        self.itemImage?.sd_setImage(with: URL(string:(model?.GoodsSeriesIcon ?? "")), completed: nil)
        self.orderNoLabel?.text = String(format: "订单号：%@", arguments: [model?.ContractNo ?? ""])
        self.itemParameter?.text = model?.GoodsExplain ?? ""
        let amount = Double(model?.ContractAmount ?? "0.00")
        self.priceLabel?.text = String(format: "共%@件商品     合计：¥%.2f", arguments: [model?.ContractQuantity ?? "",amount!])
    }
    
    @objc func tapBubble() {
        
        self.delegate?.didTapMessageBubbleWithModel(eventText: eventText!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
protocol MessageEventCellDelegate : NSObjectProtocol{
    
    func didTapMessageBubbleWithModel(eventText:String)

}
