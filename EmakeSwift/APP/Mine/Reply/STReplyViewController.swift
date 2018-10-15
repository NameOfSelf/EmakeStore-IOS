//
//  STReplyViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/15.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Toast

class STReplyViewController: BaseViewController {
    var table : UITableView?
    static let ReplyCell = "ReplyCell"
    let viewModel = STReplyViewModel()
    var replyDataList : [STReplyModel]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "自动回复"
        self.baseSetNavLeftButtonIsBack()
        self.getAutoReplyData()
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
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
        })
    }
    
    func getAutoReplyData() {
        
        var storeId : String?
        let UserDefalultStoreId = UserDefaults.standard.object(forKey: EmakeStoreId)
        if UserDefalultStoreId == nil{
            self.view.makeToast("店铺信息错误", duration: 1.0, position: CSToastPositionCenter)
            return
        }else{
            storeId = UserDefalultStoreId as? String
        }
        let parameters: NSDictionary = ["StoreId":storeId!]
        viewModel.getAutoReplyInfo(self, pamameters: parameters) { (replyList) in
            self.replyDataList = replyList as? [STReplyModel]
            self.table?.reloadData()
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
extension STReplyViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = STReplyTableViewCell.init(style: .default, reuseIdentifier: STReplyViewController.ReplyCell)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        if indexPath.section == 0 {
            cell.titleLabel?.text = "首次"
            cell.switchIsOn?.isOn = false
            cell.contentLabel?.text = "在控制台添加自己想说的话吧"
        }else{
            cell.titleLabel?.text = "夜间"
            cell.switchIsOn?.isOn = false
            cell.timeLabel?.text = "22:00~第二天的9:00"
            cell.contentLabel?.text = "在控制台添加自己想说的话吧"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeightRate(actureValue: 88)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeightRate(actureValue: 9)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return TableViewFooterNone
    }
}
