//
//  STUserListViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/5.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import MJRefresh
import Toast
import RxSwift
import RxCocoa
class STUserListViewController: BaseViewController {

    var searchBar : UISearchBar?
    var titleView : STTitleSelectView?
    var topView : UIView?
    var scrollView : UIScrollView?
    var dataListOne : [STUserModel]? = []
    var dataListTwo : [STUserModel]? = []
    var isMaxPageOne : Bool = false
    var isMaxPageTwo : Bool = false
    var pageNumberOne : NSInteger = 1
    var pageNumberTwo : NSInteger = 1
    var selectIndex : NSInteger = 0
    let viewModel = STUserListViewModel()
    let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "用户"
        NotificationCenter.default.addObserver(self, selector: #selector(loginUserRefresh), name: NSNotification.Name(rawValue: NotificationLoginRefresh), object: nil)
        // Do any additional setup after loading the view.
    }

    
    @objc func loginUserRefresh() {
        
    }
    
    override func configSubviews() {
        
        self.topView = UIView()
        self.topView?.backgroundColor = .white
        self.view.addSubview(self.topView!)
        
        self.searchBar = UISearchBar()
        self.searchBar?.placeholder = "请输入用户名称/手机号码"
        self.searchBar?.delegate = self
        self.searchBar?.barTintColor = .white
        self.searchBar?.searchBarStyle = .minimal
        self.searchBar?.backgroundColor = .clear
        let searchField = self.searchBar?.value(forKey: "searchField") as! UITextField
        searchField.setValue(TextColor_999999, forKey: "textColor")
        searchField.setValue(AdaptFont(actureValue: 14), forKey: "font")
        topView?.addSubview(self.searchBar!)
        
        self.titleView = STTitleSelectView.init(frame: CGRect(x: 0, y: HeightRate(actureValue: 55), width: ScreenWidth, height: HeightRate(actureValue: 37)), titles: ["未成交会员","已成交用户"])
        self.titleView?.delgate = self
        self.titleView?.backgroundColor = .white
        topView?.addSubview(self.titleView!)
        let height = (TableBarHeight) +  (NavigationBarHeight)
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: HeightRate(actureValue: 93), width: ScreenWidth, height: ScreenHeight - HeightRate(actureValue: 93) - CGFloat(height)))
        self.scrollView?.delegate = self
        self.scrollView?.bounces = false
        self.scrollView?.contentSize = CGSize(width: ScreenWidth*2, height: 0)
        self.scrollView?.isPagingEnabled = true
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.scrollView!)
        
        for i in 0..<2{
            let table = UITableView(frame: .zero, style: .grouped)
            table.delegate = self
            table.dataSource = self
            table.tag = 100 + i
            table.backgroundColor = .clear
            table.separatorStyle = .none
            table.estimatedRowHeight = 0
            table.estimatedSectionFooterHeight = TableViewFooterNone
            table.frame = CGRect(x: ScreenWidth*CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight - HeightRate(actureValue: 93) - CGFloat(height))
            table.headerRefresh(block: {
                self.tableViewHeaderRefresh(table)
            })
            table.footerRefresh(block: {
                self.tableViewFooterRefresh(table)
            })
            table.mj_header.beginRefreshing()
            self.scrollView?.addSubview(table)
        }
        
    }
    
    override func snapSubviews() {
        
        self.topView?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(HeightRate(actureValue: 92))
        })
        
        self.searchBar?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: -15))
            make.top.equalTo(HeightRate(actureValue: 10))
            make.height.equalTo(HeightRate(actureValue: 35))
        })
        
    }
    
    private func tableViewHeaderRefresh(_ table:UITableView){
        var CategoryId : String?
        let UserDefalultStoreCategoryBId = UserDefaults.standard.object(forKey: EmakeStoreCategoryBId)
        if UserDefalultStoreCategoryBId == nil{
            self.view.makeToast("店铺信息错误", duration: 1.0, position: CSToastPositionCenter)
            return
        }else{
            CategoryId = UserDefalultStoreCategoryBId as? String
        }
        let parameters: NSDictionary = ["CategoryId":CategoryId!,"PageIndex":1,"PageSize":10]
        table.mj_footer.resetNoMoreData()
        if table.tag == 100{
            viewModel.getUsersList(self, pamameters: parameters, successBlock: { (userList) in
                self.dataListOne = userList as? [STUserModel]
                table.mj_header.endRefreshing()
                self.isMaxPageOne = false
                table.reloadData()
            }) { (error) in
                table.mj_header.endRefreshing()
            }
        }else{
            viewModel.getTransactionUsers(self, pamameters: parameters, successBlock: { (userList) in
                self.dataListTwo = userList as? [STUserModel]
                table.mj_header.endRefreshing()
                self.isMaxPageTwo = false
                table.reloadData()
            }) { (error) in
                table.mj_header.endRefreshing()
            }
        }
    }
    
    private func tableViewFooterRefresh(_ table:UITableView){
        
        var CategoryId : String?
        let UserDefalultStoreCategoryBId = UserDefaults.standard.object(forKey: EmakeStoreCategoryBId)
        if UserDefalultStoreCategoryBId == nil{
            self.view.makeToast("店铺信息错误", duration: 1.0, position: CSToastPositionCenter)
            return
        }else{
            CategoryId = UserDefalultStoreCategoryBId as? String
        }
        if table.tag == 100{
            self.pageNumberOne = self.pageNumberOne + 1
            if self.isMaxPageOne {
                table.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            let parameters: NSDictionary = ["CategoryId":CategoryId!,"PageIndex":10,"PageSize":self.pageNumberOne]
            
            viewModel.getUsersList(self, pamameters: parameters, successBlock: { (userList) in
                let users = userList as! [STUserModel]
                if users.count < 10{
                    self.isMaxPageOne = true
                    table.mj_footer.endRefreshingWithNoMoreData()
                }
                self.dataListOne?.append(contentsOf: users)
                table.mj_footer.endRefreshing()
                table.reloadData()
            }) { (error) in
                self.pageNumberOne = self.pageNumberOne - 1
                table.mj_footer.endRefreshing()
            }
        }else{
            self.pageNumberTwo = self.pageNumberTwo + 1
            if self.isMaxPageTwo {
                table.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            let parameters: NSDictionary = ["CategoryId":CategoryId!,"PageIndex":10,"PageSize":self.pageNumberTwo]
            viewModel.getTransactionUsers(self, pamameters: parameters, successBlock: { (userList) in
                let users = userList as! [STUserModel]
                if users.count < 10{
                    self.isMaxPageTwo = true
                    table.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
                self.dataListTwo?.append(contentsOf: users)
                table.mj_footer.endRefreshing()
                table.reloadData()
            }) { (error) in
                self.pageNumberTwo = self.pageNumberTwo - 1
                table.mj_footer.endRefreshing()
            }
        }
        
    }
    func goChatVC(userModel:STUserModel) {
        
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + userModel.UserId!
        MQTTClientDefault.shared().subcribeTo(topic: topic)
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        vc.userId = userModel.UserId
        if (userModel.NickName != nil) && (userModel.NickName?.count != 0) {
            vc.userName = userModel.NickName
        }else{
            if userModel.RealName == nil || userModel.RealName?.count == 0{
                vc.userName = "用户" + userModel.MobileNumber![(userModel.MobileNumber?.count)!-4..<(userModel.MobileNumber?.count)!]
            }else{
                vc.userName = userModel.RealName
            }
        }
        vc.userAvatar = userModel.HeadImageUrl
        vc.userPhone = userModel.MobileNumber
        vc.userType = userModel.UserIdentity
        if (userModel.RemarkName == nil || userModel.RemarkName?.count == 0) && (userModel.RemarkCompany == nil || userModel.RemarkCompany?.count == 0){
            vc.userRemarkName = ""
        }else{
            vc.userRemarkName = String(format: "%@ %@", arguments: [userModel.RemarkCompany ?? "",userModel.RemarkName ?? ""])
        }
        vc.endBlock = {  text in
            let deleteClientId = "user/" + text
            RealmChatTool.deleteChatListData(with: deleteClientId)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchUserWith(searchText:String) {
        var SearchStyle = ""
        if self.selectIndex == 0{
            SearchStyle = "2"
        }else if self.selectIndex == 1{
            SearchStyle = "1"
        }
        var CategoryId : String?
        let UserDefalultStoreCategoryBId = UserDefaults.standard.object(forKey: EmakeStoreCategoryBId)
        if UserDefalultStoreCategoryBId == nil{
            self.view.makeToast("店铺信息错误", duration: 1.0, position: CSToastPositionCenter)
            return
        }else{
            CategoryId = UserDefalultStoreCategoryBId as? String
        }
        let parameters: NSDictionary = ["pageIndex":"1","pageSize":1000000,"SearchContent":searchText,"CategoryBId":CategoryId!,"SearchStyle":SearchStyle]
        viewModel.searchUserList(self, pamameters: parameters) { (modelList) in
            let vc = STSearchUserViewController()
            vc.dataList = modelList as? [STUserModel]
            if self.selectIndex == 0 {
                vc.isVip = true
            }else if self.selectIndex == 1{
                vc.isVip = false
            }
            self.searchBar?.text = ""
            self.navigationController?.pushViewController(vc, animated: true)
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
extension STUserListViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let index = scrollView.contentOffset.x/ScreenWidth
            self.selectIndex = NSInteger(index)
            self.titleView?.changeItemWithIndex(index: NSInteger(index))
        }
    }
}
extension STUserListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar?.endEditing(true)
        if self.searchBar?.text == nil || (self.searchBar?.text?.count)! <= 0{
            self.view.makeToast("请输入用户名或手机号", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        self.searchUserWith(searchText:(self.searchBar?.text)!)
    }
}
extension STUserListViewController : STTitleSelectViewDelgate {
    
    func selectItemWithIndex(index: NSInteger) {
        self.selectIndex = index
        self.scrollView?.setContentOffset(CGPoint(x: ScreenWidth*CGFloat(index), y: 0), animated: true)
    }
}
extension STUserListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 100 {
            return (self.dataListOne?.count)!
        }else{
            return (self.dataListTwo?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = STUserTableViewCell.init(style: .default, reuseIdentifier: "UserCell")
        cell.selectionStyle = .none
        var userModel : STUserModel?
        if tableView.tag == 100 {
            userModel = self.dataListOne?[indexPath.row]
            cell.setData(model:userModel!,isVip:true)
        }else{
            userModel = self.dataListTwo?[indexPath.row]
            cell.setData(model:userModel!,isVip:false)
        }
        cell.sendMessage?.rx.tap.subscribe(onNext: { [weak self] in
            self?.goChatVC(userModel: userModel!)
        }).disposed(by: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return HeightRate(actureValue: 74)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UILabel()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: HeightRate(actureValue: 5))
        headerView.backgroundColor = BaseColor.BackgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
        let vc = STUserInfoViewController()
        if tableView.tag == 100 {
            vc.userModel = self.dataListOne?[indexPath.row]
            vc.isVipUser = true
        }else{
            vc.userModel = self.dataListTwo?[indexPath.row]
            vc.isVipUser = false
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
