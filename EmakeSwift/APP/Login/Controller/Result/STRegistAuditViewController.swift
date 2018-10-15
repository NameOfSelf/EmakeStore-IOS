//
//  STRegistAuditViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/18.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STRegistAuditViewController: BaseViewController {
    
    var auditImageView : UIImageView?
    var contentLabel : UILabel?
    var timeLabel : UILabel?
    var serversCallLabel : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        self.view.backgroundColor = .white
        self.baseSetNavLeftButtonIsBack()
        // Do any additional setup after loading the view.
    }

    override func configSubviews() {
        
        self.auditImageView = UIImageView(image: UIImage(named: "tuzi02"))
        self.auditImageView?.contentMode = .scaleAspectFit
        self.view.addSubview(self.auditImageView!)
        
        self.contentLabel = UILabel()
        self.contentLabel?.textColor = TextColor_666666
        self.contentLabel?.font = AdaptFont(actureValue: 13)
        self.contentLabel?.textAlignment = .center
        self.contentLabel?.text = "感谢您对易智造的支持，平台审核需要1-3个工作日，请耐心等待。"
        self.contentLabel?.numberOfLines = 2
        self.view.addSubview(self.contentLabel!)
        
        self.timeLabel = UILabel()
        self.timeLabel?.textColor = TextColor_999999
        self.timeLabel?.font = AdaptFont(actureValue: 13)
        self.timeLabel?.text = "提交时间：2018-04-22"
        self.view.addSubview(self.timeLabel!)
        
        self.serversCallLabel = UILabel()
        self.serversCallLabel?.textColor = TextColor_FF9900
        self.serversCallLabel?.font = AdaptFont(actureValue: 13)
        self.serversCallLabel?.text = "客服热线：400-867-0211"
        self.view.addSubview(self.serversCallLabel!)
        
    }
    
    override func snapSubviews() {
    
        self.auditImageView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(HeightRate(actureValue: 104))
            make.width.equalTo(WidthRate(actureValue: 148))
            make.height.equalTo(HeightRate(actureValue: 116))
        })
        
        self.contentLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo((self.auditImageView?.snp.bottom)!).offset(HeightRate(actureValue: 52))
            make.width.equalTo(WidthRate(actureValue: 249))
        })
        
        self.timeLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo((self.contentLabel?.snp.bottom)!).offset(HeightRate(actureValue: 46))
        })
        
        self.serversCallLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo((self.timeLabel?.snp.bottom)!)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
