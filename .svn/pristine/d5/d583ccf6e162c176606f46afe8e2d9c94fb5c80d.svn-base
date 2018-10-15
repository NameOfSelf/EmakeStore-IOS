//
//  STRegistAuditSuccessViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/18.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STRegistAuditSuccessViewController: BaseViewController {
    
    var auditImageView : UIImageView?
    var contentLabel : UILabel?
    var enterButton : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        self.view.backgroundColor = .white
        self.baseSetNavLeftButtonIsBack()
        // Do any additional setup after loading the view.
    }

    override func configSubviews() {
        
        self.auditImageView = UIImageView(image: UIImage(named: "tuzi03"))
        self.auditImageView?.contentMode = .scaleAspectFit
        self.view.addSubview(self.auditImageView!)
        
        self.contentLabel = UILabel()
        self.contentLabel?.textColor = TextColor_666666
        self.contentLabel?.font = AdaptFont(actureValue: 13)
        self.contentLabel?.textAlignment = .center
        self.contentLabel?.text = "恭喜您，审核成功！"
        self.view.addSubview(self.contentLabel!)
        
        self.enterButton = UIButton(type: .custom)
        self.enterButton?.setTitleColor(.white, for: .normal)
        self.enterButton?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        self.enterButton?.titleLabel?.font = AdaptFont(actureValue: 16)
        self.enterButton?.setTitle("进入", for: .normal)
        self.enterButton?.addTarget(self, action: #selector(enterIn), for: .touchUpInside)
        self.view.addSubview(self.enterButton!)
        
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
        })
        
        self.enterButton?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(HeightRate(actureValue: 40))
        })
    }
    
    
    @objc func enterIn() {
        UserDefaults.standard.set(true, forKey: EmakeShowPassView)
        UserDefaults.standard.synchronize()
        self.navigationController?.popToRootViewController(animated: true)
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
