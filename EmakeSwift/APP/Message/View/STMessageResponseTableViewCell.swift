//
//  STMessageResponseTableViewCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STMessageResponseTableViewCell: UITableViewCell {
    
    var headImage : UIImageView?
    var flagImage : UIImageView?
    var nameLabel : UILabel?
    var messageLabel : UILabel?
    var timelabel : UILabel?
    var userTypeLabel : UILabel?
    var switchLabel : UILabel?
    var responseButton : UIButton?
    var line : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snpSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configSubViews() {
        
        self.headImage = UIImageView()
        self.headImage?.contentMode = .scaleAspectFit
        self.headImage?.layer.cornerRadius = WidthRate(actureValue: 25)
        self.headImage?.clipsToBounds = true
        self.contentView.addSubview(self.headImage!)
        
        self.flagImage = UIImageView()
        self.flagImage?.contentMode = .scaleAspectFit
        self.flagImage?.layer.cornerRadius = WidthRate(actureValue: 9)
        self.flagImage?.clipsToBounds = true
        self.contentView.addSubview(self.flagImage!)
        
        self.nameLabel = UILabel()
        self.nameLabel?.font = AdaptFont(actureValue: 16)
        self.contentView.addSubview(self.nameLabel!)
        
        self.switchLabel = UILabel()
        self.switchLabel?.font = AdaptFont(actureValue: 13)
        self.switchLabel?.textColor = TextColor_FFCC00
        self.contentView.addSubview(self.switchLabel!)
        
        
        self.messageLabel = UILabel()
        self.messageLabel?.font = AdaptFont(actureValue: 14)
        self.messageLabel?.textColor = TextColor_666666
        self.contentView.addSubview(self.messageLabel!)
        
        self.timelabel = UILabel()
        self.timelabel?.font = AdaptFont(actureValue: 12)
        self.timelabel?.textColor = TextColor_888888
        self.contentView.addSubview(self.timelabel!)
        
        self.responseButton = UIButton(type: .custom)
        self.responseButton?.setTitle("应答", for: .normal)
        self.responseButton?.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        self.responseButton?.titleLabel?.font = AdaptFont(actureValue: 14)
        self.responseButton?.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        self.responseButton?.layer.borderWidth = WidthRate(actureValue: 1)
        self.responseButton?.layer.cornerRadius = HeightRate(actureValue: 15)
        self.contentView.addSubview(self.responseButton!)
        
        self.line = UILabel()
        self.line?.backgroundColor = BaseColor.SepratorLineColor
        self.contentView.addSubview(self.line!)
    }
    private func snpSubViews() {
        
        self.headImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 15))
            make.height.equalTo(WidthRate(actureValue: 50))
            make.width.equalTo(WidthRate(actureValue: 50))
            make.centerY.equalTo(self.contentView.snp.centerY)
        })
        
        self.flagImage?.snp.makeConstraints({ (make) in
            make.centerY.equalTo((self.headImage?.snp.centerY)!).offset(HeightRate(actureValue: 16))
            make.centerX.equalTo((self.headImage?.snp.centerX)!).offset(HeightRate(actureValue: 16))
            make.width.equalTo(WidthRate(actureValue: 18))
            make.height.equalTo(WidthRate(actureValue: 18))
        })
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo(HeightRate(actureValue: 15))
            make.height.equalTo(HeightRate(actureValue: 18))
        })
        
        self.switchLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo((self.nameLabel?.snp.bottom)!).offset(HeightRate(actureValue: 5))
        })
        
        self.messageLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo((self.switchLabel?.snp.bottom)!).offset(HeightRate(actureValue: 2))
            make.height.equalTo(HeightRate(actureValue: 14))
            make.right.equalTo(WidthRate(actureValue: -90))
        })
        
        self.timelabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -15))
            make.top.equalTo(HeightRate(actureValue: 15))
            make.height.equalTo(HeightRate(actureValue: 13))
        })
        
        self.responseButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -15))
            make.bottom.equalTo(HeightRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 30))
            make.width.equalTo(WidthRate(actureValue: 70))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        })
    }
    
    public func setData(data:MessageModel) {
        if data.isSwitchMessage ?? false {
            self.switchLabel?.isHidden = false
            self.switchLabel?.text = String(format: "由客服%@转接", arguments: [data.switchServerID ?? ""])
        }else{
            self.switchLabel?.isHidden = true
        }
        if data.From?.DisplayName == nil{
            if data.From?.PhoneNumber != nil {
                self.nameLabel?.text = "用户" + (data.From?.PhoneNumber![(data.From?.PhoneNumber?.count)!-4..<(data.From?.PhoneNumber?.count)!])!
            }else{
                self.nameLabel?.text = ""
            }
        }else{
            if (data.From?.DisplayName?.count)! <= 0 {
                if data.From?.PhoneNumber != nil {
                    self.nameLabel?.text = "用户" + (data.From?.PhoneNumber![(data.From?.PhoneNumber?.count)!-4..<(data.From?.PhoneNumber?.count)!])!
                }else{
                    self.nameLabel?.text = ""
                }
            }else{
                self.nameLabel?.text = data.From?.DisplayName
            }
        }
        if data.From?.UserType == "2"{
            self.flagImage?.image = UIImage(named: "huiyuanbiaozhi")
            self.flagImage?.isHidden = false
        }else if data.From?.UserType == "3"{
            self.flagImage?.image = UIImage(named: "huiyuanbiaozhi")
            self.flagImage?.isHidden = false
        }else if data.From?.UserType == "0"{
            self.flagImage?.isHidden = true
        }else if data.From?.UserType == "1"{
            self.flagImage?.image = UIImage(named: "dailishangbiaozhi")
            self.flagImage?.isHidden = false
        }
        
        self.headImage?.sd_setImage(with: URL(string: data.From?.Avatar ?? ""), placeholderImage: UIImage(named: "yonghuyouxiangL"))
        if data.MessageBody?.Type == MessageBodyType.Text.rawValue{
            self.messageLabel?.text = data.MessageBody?.Text
        }else if data.MessageBody?.Type == MessageBodyType.Image.rawValue{
            self.messageLabel?.text = "[图片]"
        }else if data.MessageBody?.Type == MessageBodyType.Voice.rawValue{
            self.messageLabel?.text = "[语音]"
        }else if data.MessageBody?.Type == MessageBodyType.MutilePart.rawValue{
            self.messageLabel?.text = "[合同]"
        }else if data.MessageBody?.Type == MessageBodyType.Goods.rawValue{
            self.messageLabel?.text = "[商品]"
        }else if data.MessageBody?.Type == MessageBodyType.File.rawValue{
            self.messageLabel?.text = "[文件]"
        }else if data.MessageBody?.Type == MessageBodyType.Order.rawValue{
            self.messageLabel?.text = "[订单]"
        }
        self.timelabel?.text = NSDate().changeTimeIntervalToTimeStringAnother(Int(data.Timestamp!))
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
