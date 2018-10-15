//
//  STMessageConnvientReplyViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/28.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import HTHorizontalSelectionList

class STMessageConnvientReplyViewController: BaseViewController {
    
    let viewModel = STMessageConnvientReplyViewModel()
    var dataList : [STMessageConnvientReplyModel]? = []
    var titles : [String]? = []
    var content : [String]? = []
    var table : UITableView?
    var selctionList : HTHorizontalSelectionList?
    var selectMessage : String? = ""
    var confirmButton : UIButton?
    typealias selectConnvientReplyBlock = (String?) -> Void
    var block : selectConnvientReplyBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "快捷回复"
        self.baseSetNavLeftButtonIsBack()
        self.getConnvientReplyData()
        // Do any additional setup after loading the view.
    }
    
    func getConnvientReplyData(){
        
        viewModel.getConnvientReply(self) { (connvientReplyList) in
            
            self.dataList = connvientReplyList as? [STMessageConnvientReplyModel]
            for model in self.dataList! {
                if !((self.titles?.contains(model.ProblemType!))!) {
                    self.titles?.append(model.ProblemType!)
                }
            }
            if (self.titles?.count)! > 0 {
                let type = self.titles![0]
                for model in self.dataList! {
                    if type == model.ProblemType{
                        self.content?.append(model.Content ?? "")
                    }
                }
            }
            self.configAndSnpSubviews()
        }
    }
    
    func configAndSnpSubviews() {
        
        self.selctionList = HTHorizontalSelectionList(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: HeightRate(actureValue: 44)))
        self.selctionList?.delegate = self
        self.selctionList?.dataSource = self
        self.selctionList?.snapToCenter = true
        self.selctionList?.setTitleColor(.black, for: .normal)
        self.selctionList?.selectionIndicatorColor = BaseColor.APP_THEME_MAIN_COLOR
        self.selctionList?.bottomTrimColor = BaseColor.SepratorLineColor
        self.view.addSubview(self.selctionList!)
        
        
        self.table = UITableView(frame: .zero, style: .plain)
        self.table?.delegate = self
        self.table?.dataSource = self
        self.table?.separatorColor = BaseColor.SepratorLineColor
        self.table?.estimatedSectionFooterHeight = TableViewFooterNone
        self.table?.estimatedSectionHeaderHeight = TableViewHeaderNone
        self.table?.backgroundColor = .clear
        self.view.addSubview(self.table!)
        
        self.selctionList?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(HeightRate(actureValue: 44))
        })
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(HeightRate(actureValue: -60))
            make.top.equalTo((self.selctionList?.snp.bottom)!)
        })
        
        self.confirmButton = UIButton(type: .custom)
        self.confirmButton?.setTitle("确定", for: .normal)
        self.confirmButton?.setTitleColor(.white, for: .normal)
        self.confirmButton?.titleLabel?.font = AdaptFont(actureValue: 16)
        self.confirmButton?.layer.cornerRadius = WidthRate(actureValue: 4)
        self.confirmButton?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        self.confirmButton?.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        self.view.addSubview(self.confirmButton!)
        
        self.confirmButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(WidthRate(actureValue: 260))
            make.height.equalTo(HeightRate(actureValue: 40))
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(HeightRate(actureValue: -30))
        })
    
    }
    
    @objc func confirm() {
        
        self.block!(selectMessage)
        self.navigationController?.popViewController(animated: true)
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
extension STMessageConnvientReplyViewController : HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource{
    
    func selectionList(_ selectionList: HTHorizontalSelectionList, didSelectButtonWith index: Int) {
        
        self.content?.removeAll()
        let type = self.titles![index]
        for model in self.dataList! {
            if type == model.ProblemType{
                self.content?.append(model.Content ?? "")
            }
        }
        self.table?.reloadData()
    }
    
    func numberOfItems(in selectionList: HTHorizontalSelectionList) -> Int {
        
        return (self.titles?.count)!
    }
    
    func selectionList(_ selectionList: HTHorizontalSelectionList, titleForItemWith index: Int) -> String? {
        
        return self.titles?[index]
    }
}
extension STMessageConnvientReplyViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.content?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.content?[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        let selectImage = UIImageView(image: UIImage(named: "select_yes"))
        selectImage.tag = 100
        selectImage.isHidden = true
        cell.addSubview(selectImage)
        cell.selectionStyle = .none
        selectImage.snp.makeConstraints { (make) in
            make.right.equalTo(WidthRate(actureValue: -10))
            make.width.equalTo(WidthRate(actureValue: 15))
            make.height.equalTo(WidthRate(actureValue: 15))
            make.centerY.equalTo(cell.contentView.snp.centerY)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return HeightRate(actureValue: 5)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectMessage = self.content?[indexPath.row]
        let cell = table?.cellForRow(at: indexPath)
        let selectImage = cell?.viewWithTag(100) as! UIImageView
        selectImage.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = table?.cellForRow(at: indexPath)
        let selectImage = cell?.viewWithTag(100) as! UIImageView
        selectImage.isHidden = true
    }
    
    
}
