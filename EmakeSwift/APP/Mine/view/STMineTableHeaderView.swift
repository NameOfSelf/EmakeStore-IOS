//
//  STMineTableHeaderView.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/10.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STMineTableHeaderView: UIView {
    
    var headImage : UIImageView?
    var nameLabel : UILabel?
    var categoryLabel : UILabel?
    var serverLabel : UILabel?
    var backgoundImage : UIImageView?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.configSubViews()
        self.snapSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubViews() {
        
        self.backgoundImage = UIImageView(image: UIImage(named: "bg"))
        self.backgoundImage?.backgroundColor = .white
        self.addSubview(self.backgoundImage!)
        
        self.headImage = UIImageView()
        self.headImage?.layer.cornerRadius = WidthRate(actureValue: 30)
        self.headImage?.image = UIImage(named:"guanfangkefu")
        self.headImage?.clipsToBounds = true
        if UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) != nil{
            let storeImage = UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) as? String
            self.headImage?.sd_setImage(with: URL(string: storeImage!), placeholderImage: UIImage(named:"guanfangkefu"))
        }
        self.addSubview(self.headImage!)
        
        self.nameLabel = UILabel()
        self.nameLabel?.textColor = .white
        self.nameLabel?.font = AdaptFont(actureValue: 15)
        if UserDefaults.standard.object(forKey: EmakeUserNickName) != nil{
            self.nameLabel?.text = UserDefaults.standard.object(forKey: EmakeUserNickName) as? String
        }else{
            self.nameLabel?.text = UserDefaults.standard.object(forKey: EmakeUserPhoneNumber) as? String
        }
        self.addSubview(self.nameLabel!)
        
        self.categoryLabel = UILabel()
        self.categoryLabel?.textColor = .white
        self.categoryLabel?.font = AdaptFont(actureValue: 12)
        if UserDefaults.standard.object(forKey: EmakeStoreCategoryBName) != nil{
            self.categoryLabel?.text = "主营类目： \(UserDefaults.standard.object(forKey: EmakeStoreCategoryBName) as! String)"
        }else{
            self.categoryLabel?.text = "主营类目："
        }
        self.addSubview(self.categoryLabel!)
        
        self.serverLabel = UILabel()
        self.serverLabel?.textColor = .white
        if UserDefaults.standard.object(forKey: EmakeUserServiceID) != nil{
            let serverID = UserDefaults.standard.object(forKey: EmakeUserServiceID) as? String
            self.serverLabel?.text = String(format: "客服工号： %@", arguments: [serverID!])
        }else{
            self.serverLabel?.text = "客服工号："
        }
        self.serverLabel?.font = AdaptFont(actureValue: 12)
        self.addSubview(self.serverLabel!)
        
    }
    
    private func snapSubviews() {
        
        self.backgoundImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        
        self.headImage?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 17))
            make.width.equalTo(WidthRate(actureValue: 60))
            make.height.equalTo(WidthRate(actureValue: 60))
            make.centerY.equalTo(self.snp.centerY)
        })
        
        
        self.nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 14))
            make.top.equalTo((self.headImage?.snp.top)!)
            make.height.equalTo(WidthRate(actureValue: 21))
        })
        
        self.categoryLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 14))
            make.top.equalTo((self.nameLabel?.snp.bottom)!)
            make.height.equalTo(WidthRate(actureValue: 21))
        })
        
        
        self.serverLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.headImage?.snp.right)!).offset(WidthRate(actureValue: 14))
            make.top.equalTo((self.categoryLabel?.snp.bottom)!)
            make.height.equalTo(WidthRate(actureValue: 21))
        })
    }
}
