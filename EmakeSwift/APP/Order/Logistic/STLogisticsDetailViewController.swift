//
//  STLogisticsDetailViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STLogisticsDetailViewController: BaseViewController {
    var orderModel :  STOrderModel?
    var table : UITableView?
    let viewModel = STOrderDetailViewModel()
    static let LogisticsCell = "LogisticsCell"
    var logisticsList : [STLogosticsModel]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "物流详情"
        self.baseSetNavLeftButtonIsBack()
        self.getShippingInfo()
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
            make.left.right.top.bottom.equalTo(0)
        })
    }
    
    func getShippingInfo(){
        
        let parameters: NSDictionary = ["ContractNo":self.orderModel?.ContractNo!]
        viewModel.getShipingInfo(self, parameters: parameters) { (logisticList) in
            self.logisticsList = logisticList as? [STLogosticsModel]
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
extension STLogisticsDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (self.logisticsList?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = STLogisticsCell.init(style: .default, reuseIdentifier: STLogisticsDetailViewController.LogisticsCell)
        cell.selectionStyle = .none
        cell.setData(model:self.logisticsList![indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.logisticsList![indexPath.section]
        let height = 93 + (model.Goods?.count)! * 20
        return HeightRate(actureValue: CGFloat(height))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return HeightRate(actureValue: 42)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = self.logisticsList![section]
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: HeightRate(actureValue: 42))
        view.backgroundColor = BaseColor.SepratorLineColor
        let dateLabel = UILabel()
        dateLabel.textColor = TextColor_999999
        dateLabel.font = AdaptFont(actureValue: 15)
        dateLabel.text = model.ShippingDate
        view.addSubview(dateLabel)
        
        let countLabel = UILabel()
        countLabel.textColor = TextColor_666666
        countLabel.font = AdaptFont(actureValue: 15)
        var count = 0
        if (model.Goods?.count)! > 0 {
            for ship in model.Goods! {
                if ship.ShippingNumber != nil{
                    count = count + ship.ShippingNumber!
                }
            }
        }
        countLabel.text = String(format: "已发数量：%d", arguments: [count])
        view.addSubview(countLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 16))
            make.centerY.equalTo(view.snp.centerY)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(WidthRate(actureValue: -12))
            make.centerY.equalTo(view.snp.centerY)
        }
        return view
    }
}
