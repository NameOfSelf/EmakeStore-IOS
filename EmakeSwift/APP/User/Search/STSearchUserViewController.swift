//
//  STSearchUserViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class STSearchUserViewController: BaseViewController {
    var table = UITableView()
    var isVip : Bool? = true
    var dataList : [STUserModel]? 
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索结果"
        self.baseSetNavLeftButtonIsBack()
        // Do any additional setup after loading the view.
    }
    override func configSubviews() {
        
        self.table = UITableView(frame: .zero, style: .plain)
        self.table.delegate = self
        self.table.dataSource = self
        self.table.backgroundColor = .clear
        self.table.separatorStyle = .none
        self.table.estimatedRowHeight = 0
        self.table.estimatedSectionFooterHeight = TableViewFooterNone
        self.view.addSubview(self.table)
        if (self.dataList?.count)! > 0 {
            self.table.isHidden = false
        }else{
            self.table.isHidden = true
            self.configEmptyViews()
        }
        
    }
    func configEmptyViews() {
        
        let image = UIImageView(image: UIImage(named: "icon_no_data"))
        self.view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(WidthRate(actureValue: 148))
            make.height.equalTo(WidthRate(actureValue: 148))
            make.top.equalTo(HeightRate(actureValue: 100))
        }
        
        let label = UILabel()
        label.text = "抱歉，没有找到相关用户"
        label.textColor = TextColor_333333
        label.font = AdaptFont(actureValue: 13)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(image.snp.bottom).offset(HeightRate(actureValue: 3))
        }
        
    }
    override func snapSubviews() {
        
        self.table.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        })
    }
    
    
    
    func goChatVC(userModel:STUserModel) {
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + userModel.UserId!
        MQTTClientDefault.shared().subcribeTo(topic: topic)
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        vc.userId = userModel.UserId
        if userModel.NickName != nil {
            vc.userName = userModel.NickName
        }else{
            if userModel.RealName == nil {
                vc.userName = "用户" + userModel.MobileNumber![(userModel.MobileNumber?.count)!-4..<(userModel.MobileNumber?.count)!]
            }else{
                vc.userName = userModel.RealName
            }
        }
        vc.userAvatar = userModel.HeadImageUrl
        vc.userPhone = userModel.MobileNumber
        vc.userType = userModel.UserIdentity
        self.navigationController?.pushViewController(vc, animated: true)
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
extension STSearchUserViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.dataList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = STUserTableViewCell.init(style: .default, reuseIdentifier: "UserCell")
        cell.selectionStyle = .none
        var userModel : STUserModel?
        userModel = self.dataList?[indexPath.row]
        cell.setData(model:userModel!,isVip:true)
        cell.sendMessage?.rx.tap.subscribe(onNext: { [weak self] in
            self?.goChatVC(userModel: userModel!)
        }).disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return HeightRate(actureValue: 74)
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return TableViewHeaderNone
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        let vc = STUserInfoViewController()
        vc.isVipUser = self.isVip
        vc.userModel = self.dataList?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
