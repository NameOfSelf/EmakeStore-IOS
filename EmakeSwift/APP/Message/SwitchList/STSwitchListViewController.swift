//
//  STSwitchListViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/30.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STSwitchListViewController: BaseViewController {
    var table : UITableView?
    var switchList : [String]?
    typealias SwitchBlock = ((String) -> ())
    var block : SwitchBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseSetNavLeftButtonIsBack()
        self.title = "咨询转移"
        // Do any additional setup after loading the view.
    }
    override func configSubviews() {
        
        self.table = UITableView(frame: .zero, style: .grouped)
        self.table?.delegate = self;
        self.table?.dataSource = self;
        self.table?.showsVerticalScrollIndicator = false
        self.table?.showsHorizontalScrollIndicator = false
        self.table?.separatorColor = BaseColor.SepratorLineColor;
        self.table?.backgroundColor = .clear;
        self.table?.estimatedSectionFooterHeight = 0
        self.table?.estimatedSectionHeaderHeight = 0
        self.view.addSubview(self.table!)
    }
    
    override func snapSubviews() {
        self.table?.snp.makeConstraints({ (make) in
            make.left.top.right.bottom.equalTo(0)
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
extension STSwitchListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.switchList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "SwitchCell")
        cell.selectionStyle = .none
        let chatroom = self.switchList?[indexPath.row]
        let part = chatroom?.components(separatedBy: "/")
        cell.textLabel?.text = part?[2]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return TableViewHeaderNone
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeightRate(actureValue: 44)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let serverId = self.switchList?[indexPath.row]
        self.block!(serverId!)
        self.navigationController?.popViewController(animated: true)
    }
}
