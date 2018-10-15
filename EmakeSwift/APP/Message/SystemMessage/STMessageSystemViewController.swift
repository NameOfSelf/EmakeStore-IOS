//
//  STMessageSystemViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/9.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STMessageSystemViewController: BaseViewController {

    let viewModel = STMessageSystemViewModel()
    var pageNumber : Int? = 1
    var isMaxPage : Bool? = false
    var table : UITableView?
    var messageList : [STMessageSystemContentModel]? = []
    static let MessageSystemCell = "MessageSystemCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "系统消息"
        self.baseSetNavLeftButtonIsBack()
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
        self.table?.headerRefresh(block: {
            self.tableViewHeaderRefresh()
            self.table?.mj_header.endRefreshing()
        })
        self.table?.mj_header.beginRefreshing()
        self.table?.footerRefresh(block: {
            self.tableViewFooterRefresh()
            self.table?.mj_footer.endRefreshing()
        })
        self.view.addSubview(self.table!)
    }

    override func snapSubviews() {
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.right.bottom.top.equalTo(0)
        })
    }
    
    func tableViewHeaderRefresh() {
        
        self.table?.mj_footer.resetNoMoreData()
        self.isMaxPage = false
        let parameters: NSDictionary = ["pageIndex":1,"pageSize":10]
        viewModel.getMessageSystem(self, parameters: parameters, successBlock: { (list) in
            self.messageList = list as? [STMessageSystemContentModel]
            self.table?.reloadData()
            self.table?.mj_header.endRefreshing()
        }) { (error) in
            self.table?.mj_header.endRefreshing()
        }
    }

    func tableViewFooterRefresh() {
        
        self.pageNumber = self.pageNumber! + 1
        if self.isMaxPage! {
            self.table?.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        let parameters: NSDictionary = ["pageIndex":self.pageNumber,"pageSize":10]
        viewModel.getMessageSystem(self, parameters: parameters, successBlock: { (list) in
            let messageList = list as! [STMessageSystemContentModel]
            if messageList.count < 5{
                self.isMaxPage = true
                self.table?.mj_footer.endRefreshingWithNoMoreData()
            }
            self.messageList?.append(contentsOf: messageList)
            self.table?.reloadData()
            self.table?.mj_footer.endRefreshing()
        }) { (error) in
            self.pageNumber = self.pageNumber! - 1
            self.table?.mj_footer.endRefreshing()
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
extension STMessageSystemViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (self.messageList?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = STMessageSystemItemCell.init(style: .default, reuseIdentifier: STMessageSystemViewController.MessageSystemCell)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.setData(model: self.messageList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return HeightRate(actureValue: 15)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return TableViewHeaderNone
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
}
