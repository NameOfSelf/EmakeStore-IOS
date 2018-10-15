//
//  STMessageSystemItemCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STMessageSystemItemCell: UITableViewCell {

    var timeLabel : UILabel?
    var titleLabel : UILabel?
    var contentLabel : UILabel?
    var backView : UIView?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snapSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews() {
        
        self.timeLabel = UILabel()
        self.timeLabel?.textColor = TextColor_333333
        self.timeLabel?.font = AdaptFont(actureValue: 13)
        self.contentView.addSubview(self.timeLabel!)
        
        self.backView = UIView()
        self.backView?.layer.cornerRadius = WidthRate(actureValue: 3)
        self.backView?.backgroundColor = .white
        self.contentView.addSubview(self.backView!)
        
        self.titleLabel = UILabel()
        self.titleLabel?.textColor = .black
        self.titleLabel?.font = AdaptFont(actureValue: 15)
        self.backView?.addSubview(self.titleLabel!)
        
        self.contentLabel = UILabel()
        self.contentLabel?.textColor = TextColor_999999
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.font = AdaptFont(actureValue: 11)
        self.backView?.addSubview(self.contentLabel!)
    }
    
    private func snapSubViews() {
        
        self.timeLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.top.equalTo(HeightRate(actureValue: 10))
        })
        
        self.backView?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 13))
            make.right.equalTo(WidthRate(actureValue: -13))
            make.top.equalTo((self.timeLabel?.snp.bottom)!).offset(HeightRate(actureValue: 10))
            make.bottom.equalTo(0)
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 5))
            make.top.equalTo(HeightRate(actureValue: 8))
        })
        
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 5))
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(HeightRate(actureValue:8))
            make.right.equalTo(WidthRate(actureValue: -30))
            make.bottom.equalTo(HeightRate(actureValue: -8))
        })
    }
    
    public func setData(model:STMessageSystemContentModel) {
        
        self.timeLabel?.text = model.SendTime
        let content = Mapper<STMessageSystemNewModel>().map(JSONString: model.PushContent!)
        self.titleLabel?.text =   "订单信息"
        self.contentLabel?.text = content?.Content
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
