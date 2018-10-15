//
//  STUserInfoViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class STUserInfoViewController: BaseViewController {

    var table : UITableView?
    var isVipUser : Bool?
    var userModel : STUserModel?
    let viewModel = STUserInfoViewModel()
    var orderDataList : [STUserOrderModel]? = []
    static let UserInfoTopCell = "UserInfoTopCell"
    static let UserInfoCommmonCell = "UserInfoCommmonCell"
    static let UserInfoOrderCell = "UserInfoOrderCell"
    let leftTitles = ["姓名","性别","手机号码","注册时间","用户类型","会员有效期"]
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "用户资料"
        self.baseSetNavLeftButtonIsBack()
        self.getUserOrderData()
        if self.userModel?.UserIdentity == "2"{
            self.isVipUser = true
        }else if self.userModel?.UserIdentity == "3"{
            self.isVipUser = true
        }else if self.userModel?.UserIdentity == "0"{
            self.isVipUser = false
        }else if self.userModel?.UserIdentity == "1"{
            self.isVipUser = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func configSubviews() {
        
        self.table = UITableView(frame: .zero, style: .grouped)
        self.table?.delegate = self
        self.table?.dataSource = self
        self.table?.separatorStyle = .none
        self.table?.estimatedSectionFooterHeight = TableViewFooterNone
        self.table?.estimatedSectionHeaderHeight = TableViewHeaderNone
        self.table?.backgroundColor = .clear
        self.view.addSubview(self.table!)
    }
    
    override func snapSubviews() {
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.right.bottom.top.equalTo(0)
        })
    }
    
    func getUserOrderData() {
        
        let parameters: NSDictionary = ["userid":self.userModel?.UserId!]
        viewModel.getTransactionOrders(self, pamameters: parameters, successBlock: { (orderList) in
            self.orderDataList = orderList as? [STUserOrderModel]
            if (self.orderDataList?.count)! <= 0 {
                self.table?.tableFooterView = STUserInfoFooterView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: HeightRate(actureValue: 240)))
            }
            self.table?.reloadData()
        }) { (error) in
            
        }
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
extension STUserInfoViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if self.isVipUser!{
                return 6
            }else{
                return 5
            }
        case 2:
            return (self.orderDataList?.count)!
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = STUserInfoTopCell.init(style: .default, reuseIdentifier: STUserInfoViewController.UserInfoTopCell)
            cell.selectionStyle = .none
            cell.setData(model:self.userModel!,isVip:self.isVipUser!)
            cell.sendMessage?.rx.tap.subscribe(onNext: { [weak self] in
                let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
                let topic = "chatroom/" + storeId + "/" + (self?.userModel?.UserId)!
                MQTTClientDefault.shared().subcribeTo(topic: topic)
                let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
                vc.userId = self?.userModel?.UserId
                if self?.userModel?.NickName != nil {
                    vc.userName = self?.userModel?.NickName
                }else{
                    if self?.userModel?.RealName == nil {
                        vc.userName = "用户" + (self?.userModel?.MobileNumber![(self?.userModel?.MobileNumber?.count)!-4..<(self?.userModel?.MobileNumber?.count)!])!
                    }else{
                        vc.userName = self?.userModel?.RealName
                    }
                }
                
                vc.userAvatar = self?.userModel?.HeadImageUrl
                vc.userPhone = self?.userModel?.MobileNumber
                vc.userType = self?.userModel?.UserIdentity
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
            return cell
        case 1:
            let cell = STUserInfoCommonCell.init(style: .default, reuseIdentifier: STUserInfoViewController.UserInfoCommmonCell)
            cell.leftTitle?.text = self.leftTitles[indexPath.row]
            cell.selectionStyle = .none
            switch indexPath.row {
            case 0 :
                cell.rightTitle?.text = self.userModel?.RealName
            case 1 :
                if self.userModel?.Sex == "0"{
                    cell.rightTitle?.text = "男"
                }else if self.userModel?.Sex == "1"{
                    cell.rightTitle?.text = "女"
                }else{
                    cell.rightTitle?.text = "保密"
                }
            case 2 :
                
                cell.rightTitle?.text = self.userModel?.MobileNumber
            case 3 :
                if self.userModel?.CreateTime != nil {
                    cell.rightTitle?.text = self.userModel?.CreateTime
                }
            case 4 :
                if self.userModel?.UserIdentity == "2"{
                    cell.rightTitle?.text = "VIP用户"
                }else if self.userModel?.UserIdentity == "3"{
                    cell.rightTitle?.text = "体验VIP用户"
                }else if self.userModel?.UserIdentity == "0"{
                    cell.rightTitle?.text = "普通用户"
                }else if self.userModel?.UserIdentity == "1"{
                    cell.rightTitle?.text = "城市代理商"
                }
            default:
                if self.userModel?.EndAt != nil {
                    cell.rightTitle?.text = self.userModel?.EndAt
                }
            }
            return cell
        default:
            let cell = STUserInfoOrderCell.init(style: .default, reuseIdentifier: STUserInfoViewController.UserInfoOrderCell)
            cell.selectionStyle = .none
            cell.setData(model:self.orderDataList![indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return HeightRate(actureValue: 104)
        case 1:
            return HeightRate(actureValue: 44)
        default:
            return HeightRate(actureValue: 73)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return HeightRate(actureValue: 10)
        case 2:
            return HeightRate(actureValue: 30)
        default:
            return TableViewHeaderNone
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return HeightRate(actureValue: 10)
        case 1:
            return HeightRate(actureValue: 10)
        default:
            return TableViewHeaderNone
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = BaseColor.BackgroundColor
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let view = UIView()
            view.backgroundColor = .white
            
            let label  = UILabel()
            label.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
            view.addSubview(label)
            
            label.snp.makeConstraints { (make) in
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(2)
                make.height.equalTo(HeightRate(actureValue: 14))
                make.left.equalTo(WidthRate(actureValue: 12))
            }
            
            let labelTitle  = UILabel()
            labelTitle.text = "用户订单"
            labelTitle.font = AdaptBoldFont(actureValue: 12)
            view.addSubview(labelTitle)
            
            labelTitle.snp.makeConstraints { (make) in
                make.centerY.equalTo(view.snp.centerY)
                make.left.equalTo(WidthRate(actureValue: 21))
            }
            return view
        }else{
            let view = UIView()
            view.backgroundColor = BaseColor.BackgroundColor
            return view
        }
    }
}
