//
//  STOrderDetailViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/12.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Toast
class STOrderDetailViewController: BaseViewController {
    var orderModel :  STOrderModel?
    var table : UITableView?
    let disposeBag = DisposeBag()
    let viewModel = STOrderDetailViewModel()
    static let OrderDetailTopCell = "OrderDetailTopCell"
    static let OrderDetailItemCell = "OrderDetailItemCell"
    static let OrderDetailItemBottomCell = "OrderDetailItemBottomCell"
    static let OrderDetailUserCell = "OrderDetailUserCell"
    static let OrderDetailBottomCell = "OrderDetailBottomCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
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
        self.view.addSubview(self.table!)
    }
    
    func getContractPDF(contractNo:String) {
        let vc = STReuseableWebViewController()
        vc.url = String(format: "%@/%@", arguments: [WebViewURL.ContractURL.rawValue,contractNo])
        vc.webViewType = .contractPreview
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func lookUpProtocol(contractNo:String,index:NSInteger) {
        
        let parameter : NSDictionary? = ["ContractNo":contractNo]
        viewModel.getContractAgreement(self, parameters: parameter!) { (model) in
            let contract = model as! ContractModel
            let goods = contract.Products![index]
            let vc = STReuseableWebViewController()
            vc.url = String(format: "%@%@/%@", arguments: [contract.MessageBody?.ContractAgreement?.Url ?? "",contractNo,goods.MainGoodsCode ?? ""])
            vc.webViewType = .protocolPreview
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func snapSubviews() {
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
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
extension STOrderDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return (self.orderModel?.ProductList?.count)! + 1
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var orderType : OrderType?
        if self.orderModel?.OrderState == "0"{
            orderType = .待付款
        }else if self.orderModel?.OrderState == "1"{
            orderType = .生产中
        }else if self.orderModel?.OrderState == "2"{
            orderType = .生产完成
        }else if self.orderModel?.OrderState == "3"{
            orderType = .发货中
        }else if self.orderModel?.OrderState == "-2"{
            orderType = .待签订
        }
        switch indexPath.section {
        case 0:
            let cell = STOrderDetailTopCell.init(style: .default, reuseIdentifier: STOrderDetailViewController.OrderDetailTopCell, orderType: orderType!)
            cell.selectionStyle = .none
            cell.setData(model: self.orderModel!)
            return cell
        case 1:
            if indexPath.row != self.orderModel?.ProductList?.count {
                let cell = STOrderDetailItemCell.init(style: .default, reuseIdentifier: STOrderDetailViewController.OrderDetailItemCell)
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.setData(model:(self.orderModel?.ProductList![indexPath.row])!)
                cell.protocolButton?.rx.tap.subscribe(onNext: { [weak self] in
                    self?.lookUpProtocol(contractNo: self?.orderModel?.ContractNo ?? "", index: indexPath.row)
                }).disposed(by: disposeBag)
                return cell
            }else{
                let cell = STOrderDetailItemBottomCell.init(style: .default, reuseIdentifier: STOrderDetailViewController.OrderDetailItemBottomCell, orderType: orderType!)
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.setData(model: self.orderModel!)
                return cell
            }
        case 2:
            let cell = STOrderDetailUserCell.init(style: .default, reuseIdentifier: STOrderDetailViewController.OrderDetailUserCell)
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            cell.setData(model: self.orderModel!)
            cell.sendMessage?.rx.tap.subscribe(onNext: { [weak self] in
                let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
                let topic = "chatroom/" + storeId + "/" + (self?.orderModel?.UserId)!
                MQTTClientDefault.shared().subcribeTo(topic: topic)
                let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
                vc.userId = self?.orderModel?.UserId
                if self?.orderModel?.RealName == nil {
                    vc.userName = "用户" + (self?.orderModel?.MobileNumber![(self?.orderModel?.MobileNumber!.count)!-4..<(self?.orderModel?.MobileNumber!.count)!])!
                }else{
                    vc.userName = self?.orderModel?.RealName
                }
                vc.userAvatar = self?.orderModel?.HeadImageUrl
                vc.userPhone = self?.orderModel?.MobileNumber
                vc.userType = self?.orderModel?.UserIdentity
                if (self?.orderModel?.RemarkName == nil ||  self?.orderModel?.RemarkName?.count == 0) && (self?.orderModel?.RemarkCompany == nil ||  self?.orderModel?.RemarkCompany?.count == 0){
                    vc.userRemarkName = ""
                }else{
                    vc.userRemarkName = String(format: "%@ %@", arguments: [self?.orderModel?.RemarkCompany ?? "",self?.orderModel?.RemarkName ?? ""])
                }
                vc.endBlock = {  text in
                    let deleteClientId = "user/" + text
                    RealmChatTool.deleteChatListData(with: deleteClientId)
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
            return cell
        default:
            let cell = STOrderDetailBottomCell.init(style: .default, reuseIdentifier: STOrderDetailViewController.OrderDetailBottomCell, orderType: orderType!)
            cell.selectionStyle = .none
            cell.lookUpLogisticsButton?.rx.tap.subscribe(onNext: { [weak self] in
                let vc = STLogisticsDetailViewController()
                vc.orderModel = self?.orderModel
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
            cell.lookUpContractButton?.rx.tap.subscribe(onNext: { [weak self] in
                self?.getContractPDF(contractNo: self?.orderModel?.ContractNo ?? "")
            }).disposed(by: disposeBag)
            cell.contractChatButton?.rx.tap.subscribe(onNext: { [weak self] in
                let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
                let topic = "chatroom/" + storeId + "/" + (self?.orderModel?.UserId)!
                MQTTClientDefault.shared().subcribeTo(topic: topic)
                let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
                vc.userId = self?.orderModel?.UserId
                if self?.orderModel?.RealName == nil {
                    vc.userName = "用户" + (self?.orderModel?.MobileNumber![(self?.orderModel?.MobileNumber?.count)!-4..<(self?.orderModel?.MobileNumber?.count)!])!
                }else{
                    vc.userName = self?.orderModel?.RealName
                }
                vc.userAvatar = self?.orderModel?.HeadImageUrl
                vc.userPhone = self?.orderModel?.MobileNumber
                vc.userType = self?.orderModel?.UserIdentity
                if (self?.orderModel?.RemarkName == nil ||  self?.orderModel?.RemarkName?.count == 0) && (self?.orderModel?.RemarkCompany == nil ||  self?.orderModel?.RemarkCompany?.count == 0){
                    vc.userRemarkName = ""
                }else{
                    vc.userRemarkName = String(format: "%@ %@", arguments: [self?.orderModel?.RemarkCompany ?? "",self?.orderModel?.RemarkName ?? ""])
                }
                vc.endBlock = {  text in
                    let deleteClientId = "user/" + text
                    RealmChatTool.deleteChatListData(with: deleteClientId)
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return TableViewHeaderNone
        }else {
            return HeightRate(actureValue: 5)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            if self.orderModel?.Address == nil || self.orderModel?.Address?.count == 0{
                return HeightRate(actureValue: 113)
            }else{
                return HeightRate(actureValue: 186)
            }
        case 1:
            if indexPath.row != self.orderModel?.ProductList?.count{
                let productModel = self.orderModel?.ProductList![indexPath.row]
                let textMaxSize = CGSize(width: WidthRate(actureValue: 180), height: CGFloat(MAXFLOAT))
                let size = productModel?.GoodsExplain?.boundingRect(with:textMaxSize , options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : AdaptFont(actureValue: 13)], context: nil).size
                let height = (size?.height)! + HeightRate(actureValue: 40)
                var addServersHeight = 0
                if (productModel?.AddServiceInfo?.count)! > 0 {
                    addServersHeight = (productModel?.AddServiceInfo?.count)! * 16 + 10
                }else{
                    addServersHeight = 10
                }
                if height > HeightRate(actureValue: 111){
                    return (height + HeightRate(actureValue: CGFloat(addServersHeight))+HeightRate(actureValue: 65))
                }else{
                    return (HeightRate(actureValue: 111) + HeightRate(actureValue: CGFloat(addServersHeight))+HeightRate(actureValue: 65))
                }
            }else{
                return HeightRate(actureValue: 110)
            }
        case 2:
            return HeightRate(actureValue: 58)
        default:
            return HeightRate(actureValue: 54)
        }
    }
}
