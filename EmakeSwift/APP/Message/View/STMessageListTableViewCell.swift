//
//  STMessageListTableViewCell.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/29.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STMessageListTableViewCell: UITableViewCell {
    
    var headImage : UIImageView?
    var flagImage : UIImageView?
    var nameLabel : UILabel?
    var messageLabel : UILabel?
    var timelabel : UILabel?
    var messageCountLabel : UILabel?
    var line : UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configSubViews()
        self.snpSubViews()
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
        self.nameLabel?.text = "名字"
        self.contentView.addSubview(self.nameLabel!)
        
        
        self.messageLabel = UILabel()
        self.messageLabel?.font = AdaptFont(actureValue: 14)
        self.messageLabel?.textColor = TextColor_666666
        self.messageLabel?.text = "消息"
        self.contentView.addSubview(self.messageLabel!)
        
        self.timelabel = UILabel()
        self.timelabel?.font = AdaptFont(actureValue: 12)
        self.timelabel?.textColor = TextColor_888888
        self.timelabel?.text = "2019-9-10"
        self.contentView.addSubview(self.timelabel!)
        
        self.messageCountLabel = UILabel()
        self.messageCountLabel?.font = AdaptFont(actureValue: 9)
        self.messageCountLabel?.textColor = .white
        self.messageCountLabel?.clipsToBounds = true
        self.messageCountLabel?.textAlignment = .center
        self.messageCountLabel?.layer.cornerRadius = WidthRate(actureValue: 9)
        self.messageCountLabel?.backgroundColor = TextColor_FFCC00
        self.messageCountLabel?.text = "10"
        self.contentView.addSubview(self.messageCountLabel!)
        
        
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
            make.width.equalTo(WidthRate(actureValue: 200))
        })
        
        self.messageLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 10))
            make.top.equalTo((self.nameLabel?.snp.bottom)!).offset(HeightRate(actureValue: 5))
            make.height.equalTo(HeightRate(actureValue: 14))
            make.right.equalTo(WidthRate(actureValue: -90))
        })
        
        self.timelabel?.snp.makeConstraints({ (make) in
            
            make.right.equalTo(WidthRate(actureValue: -15))
            make.top.equalTo(HeightRate(actureValue: 15))
            make.height.equalTo(HeightRate(actureValue: 13))
        })

        self.messageCountLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(WidthRate(actureValue: -15))
            make.top.equalTo((self.timelabel?.snp.bottom)!).offset(HeightRate(actureValue: 4))
            make.height.equalTo(WidthRate(actureValue: 18))
            make.width.equalTo(WidthRate(actureValue: 18))
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        })
    }
    
    public func setData(data:RealmChatListData) {
        
        var serverID : String = ""
        if UserDefaults.standard.object(forKey: EmakeUserServiceID) != nil {
            serverID = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        }
        let clientSelf = String(format: "user/%@", arguments: [serverID])
        
        if data.userName == nil{
            if data.userPhone != nil {
               self.nameLabel?.text = "用户" + (data.userPhone![(data.userPhone?.count)!-4..<(data.userPhone?.count)!])
            }else{
                self.nameLabel?.text = ""
            }
        }else{
            if (data.userName?.count)! <= 0 {
                if data.userPhone != nil {
                    self.nameLabel?.text = "用户" + (data.userPhone![(data.userPhone?.count)!-4..<(data.userPhone?.count)!])
                }else{
                    self.nameLabel?.text = ""
                }
            }else{
                self.nameLabel?.text = data.userName
            }
        }
        self.headImage?.sd_setImage(with: URL(string: data.userAvata ?? ""), placeholderImage: UIImage(named: "yonghuyouxiangL"))
        if clientSelf == data.clientId {
            self.nameLabel?.text = "平台客服"
            self.headImage?.image = UIImage(named: "guanfangkefu")
        }
        if data.userType == "2"{
            self.flagImage?.image = UIImage(named: "huiyuanbiaozhi")
            self.flagImage?.isHidden = false
        }else if data.userType == "3"{
            self.flagImage?.image = UIImage(named: "huiyuanbiaozhi")
            self.flagImage?.isHidden = false
        }else if data.userType == "0"{
            self.flagImage?.isHidden = true
        }else if data.userType == "1"{
            self.flagImage?.image = UIImage(named: "dailishangbiaozhi")
            self.flagImage?.isHidden = false
        }
        let model = Mapper<MessageBodyModel>().map(JSONString: data.message!)
        if data.messageType == MessageBodyType.Text.rawValue{
            self.messageLabel?.text = model?.Text
        }else if data.messageType == MessageBodyType.Image.rawValue{
            self.messageLabel?.text = "[图片]"
        }else if data.messageType == MessageBodyType.Voice.rawValue{
            self.messageLabel?.text = "[语音]"
        }else if data.messageType == MessageBodyType.MutilePart.rawValue{
            self.messageLabel?.text = "[合同]"
        }else if data.messageType == MessageBodyType.Goods.rawValue{
            self.messageLabel?.text = "[商品]"
        }else if data.messageType == MessageBodyType.File.rawValue{
            self.messageLabel?.text = "[文件]"
        }else if data.messageType == MessageBodyType.Order.rawValue{
            self.messageLabel?.text = "[订单]"
        }
        let count = Int(data.messageCount ?? "0")
        if count! <= 0 {
            self.messageCountLabel?.isHidden = true
        }else{
            self.messageCountLabel?.text = String(format: "%d", arguments: [count!])
            self.messageCountLabel?.isHidden = false
        }
        self.timelabel?.text = NSDate().changeTimeIntervalToTimeStringAnother(Int(data.sendTime!)!)
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
