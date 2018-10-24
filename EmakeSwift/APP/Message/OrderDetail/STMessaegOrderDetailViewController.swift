//
//  STMessaegOrderDetailViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/30.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Toast
class STMessaegOrderDetailViewController: BaseViewController {
    
    typealias SendProtocolBlock = (MessageBodyModel?) -> Void
    var table : UITableView?
    let viewModel = STOrderListViewModel()
    let viewModelAnother = STOrderDetailViewModel()
    var orderModel : STOrderModel?
    var orderDataList : [STOrderModel]? = []
    var orderNo : String?
    var sendSaleButton : UIButton?
    var sendProtocolAndContractButton : UIButton?
    var contractModel : ContractModel?
    static let MessaegOrderItemCell = "MessaegOrderItemCell"
    static let MessaegOrderBottomCell = "MessaegOrderBottomCell"
    let disposeBag = DisposeBag()
    var sendBlock : SendProtocolBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单信息"
        self.view.backgroundColor = .white
        self.baseSetNavLeftButtonIsBack()
        self.getOrderData()
        self.getContactData()
        self.configBottomView()
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
    
    func configBottomView() {
        
        self.sendSaleButton = UIButton(type: .custom)
        self.sendSaleButton?.setTitle("买卖合同", for: .normal)
        self.sendSaleButton?.titleLabel?.font = AdaptFont(actureValue: 12)
        self.sendSaleButton?.layer.cornerRadius = HeightRate(actureValue: 22.5)
        self.sendSaleButton?.setImage(UIImage(named: "fasong01s"), for: .normal)
        self.sendSaleButton?.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthRate(actureValue: 12))
        self.sendSaleButton?.setTitleColor(.white, for: .normal)
        self.sendSaleButton?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        self.sendSaleButton?.addTarget(self, action: #selector(sendSale), for: .touchUpInside)
        self.view.addSubview(self.sendSaleButton!)
        
        self.sendSaleButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(WidthRate(actureValue: 150))
            make.height.equalTo(HeightRate(actureValue: 45))
            make.left.equalTo(WidthRate(actureValue: 25))
            make.bottom.equalTo(HeightRate(actureValue: -7.5))
        })
        
        
        self.sendProtocolAndContractButton = UIButton(type: .custom)
        self.sendProtocolAndContractButton?.setTitle("合同+协议", for: .normal)
        self.sendProtocolAndContractButton?.titleLabel?.font = AdaptFont(actureValue: 12)
        self.sendProtocolAndContractButton?.layer.cornerRadius = HeightRate(actureValue: 22.5)
        self.sendProtocolAndContractButton?.setImage(UIImage(named: "fasong01s"), for: .normal)
        self.sendProtocolAndContractButton?.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WidthRate(actureValue: 12))
        self.sendProtocolAndContractButton?.setTitleColor(.white, for: .normal)
        self.sendProtocolAndContractButton?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        self.sendProtocolAndContractButton?.addTarget(self, action: #selector(sendProtocolAndContract), for: .touchUpInside)
        self.view.addSubview(self.sendProtocolAndContractButton!)
        
        self.sendProtocolAndContractButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(WidthRate(actureValue: 150))
            make.height.equalTo(HeightRate(actureValue: 45))
            make.right.equalTo(WidthRate(actureValue: -25))
            make.bottom.equalTo(HeightRate(actureValue: -7.5))
        })
    }

    func getOrderData(){
        let parameters: NSDictionary? = ["RequestType":"1","OrderNo":self.orderNo!]
        viewModel.getOrderList(self, parameters: parameters!, successBlock: { (orderList) in
            self.orderDataList = orderList as? [STOrderModel]
            if (self.orderDataList?.count)! > 0 {
                self.orderModel = self.orderDataList?.first
                self.table?.reloadData()
            }
        }) { (error) in
        }
    }
    
    func getContactData(){
        
        let parameter : NSDictionary? = ["ContractNo":self.orderNo ?? ""]
        viewModelAnother.getContractAgreement(self, parameters: parameter!) { (model) in
            self.contractModel = model as? ContractModel
        }
    }

    override func snapSubviews() {
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(HeightRate(actureValue: -60))
        })
        
    }
    
    @objc func sendSale() {
        
        let body = MessageBodyModel()
        if self.contractModel?.MessageBody?.ContractHeader == nil {
            return
        }else{
            body.ContractState = self.contractModel?.MessageBody?.ContractHeader?.ContractState
            body.ImageUrl = self.contractModel?.MessageBody?.ContractHeader?.ImageUrl
            body.Text = self.contractModel?.MessageBody?.ContractHeader?.Text
            body.IsIncludeTax = self.contractModel?.MessageBody?.ContractHeader?.IsIncludeTax
            body.ContractType = self.contractModel?.MessageBody?.ContractHeader?.ContractType
            body.Image = self.contractModel?.MessageBody?.ContractHeader?.Image
        }
        body.Type = "MutilePart"
        if self.contractModel?.Products == nil {
            self.view.makeToast("该商品没有技术协议", duration: 1.0, position: CSToastPositionCenter)
            return
        }else{
            body.Contract = self.orderModel?.ContractNo
            body.Url = String(format: "%@%@", arguments: [self.contractModel?.MessageBody?.ContractHeader?.Url ?? "",self.orderModel?.ContractNo ?? ""])
        }
        let vc = STReuseableWebViewController()
        vc.url = body.Url!
        vc.webViewType = .saleContract
        vc.rightButtonTitle = "发送"
        vc.messageBody = body
        vc.sendBlock = { model in
            self.sendBlock!(model)
            for vc in (self.navigationController?.viewControllers)! {
                if vc.isKind(of: STChatViewController.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sendProtocolAndContract() {
        
        let body = MessageBodyModel()
        if self.contractModel?.MessageBody?.ContractTotal == nil {
            return
        }else{
            body.ContractState = self.contractModel?.MessageBody?.ContractTotal?.ContractState
            body.ImageUrl = self.contractModel?.MessageBody?.ContractTotal?.ImageUrl
            body.Text = self.contractModel?.MessageBody?.ContractTotal?.Text
            body.IsIncludeTax = self.contractModel?.MessageBody?.ContractTotal?.IsIncludeTax
            body.ContractType = self.contractModel?.MessageBody?.ContractTotal?.ContractType
            body.Image = self.contractModel?.MessageBody?.ContractTotal?.Image
        }
        body.Type = "MutilePart"
        body.Contract = self.orderModel?.ContractNo
        body.Url = String(format: "%@%@", arguments: [self.contractModel?.MessageBody?.ContractTotal?.Url ?? "",self.orderModel?.ContractNo ?? ""])
        let vc = STReuseableWebViewController()
        vc.url = body.Url!
        vc.webViewType = .totalContract
        vc.rightButtonTitle = "发送"
        vc.messageBody = body
        vc.sendBlock = { model in
            self.sendBlock!(model)
            for vc in (self.navigationController?.viewControllers)! {
                if vc.isKind(of: STChatViewController.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goSendProtocolVC(index:NSInteger) {
        
        if self.contractModel?.MessageBody?.ContractAgreement == nil {
            return
        }
        let goods = self.contractModel?.Products![index]
        let body = MessageBodyModel()
        if self.contractModel?.MessageBody?.ContractAgreement == nil {
            return
        }else{
            body.ContractState = self.contractModel?.MessageBody?.ContractAgreement?.ContractState
            body.ImageUrl = self.contractModel?.MessageBody?.ContractAgreement?.ImageUrl
            body.Text = self.contractModel?.MessageBody?.ContractAgreement?.Text
            body.IsIncludeTax = self.contractModel?.MessageBody?.ContractAgreement?.IsIncludeTax
            body.ContractType = self.contractModel?.MessageBody?.ContractAgreement?.ContractType
            body.Image = self.contractModel?.MessageBody?.ContractAgreement?.Image
        }
        
        body.Type = "MutilePart"
        body.Contract = self.orderModel?.ContractNo
        body.Url = String(format: "%@%@/%@", arguments: [self.contractModel?.MessageBody?.ContractAgreement?.Url ?? "",self.orderModel?.ContractNo ?? "",goods?.MainGoodsCode ?? ""])
        let vc = STReuseableWebViewController()
        vc.url = String(format: "%@%@/%@", arguments: [self.contractModel?.MessageBody?.ContractAgreement?.Url ?? "",self.orderModel?.ContractNo ?? "",goods?.MainGoodsCode ?? ""])
        vc.webViewType = .protocolPreview
        vc.rightButtonTitle = "发送"
        vc.messageBody = body
        vc.sendBlock = { model in
            self.sendBlock!(model)
            for vc in (self.navigationController?.viewControllers)! {
                if vc.isKind(of: STChatViewController.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendProtocol(index:NSInteger) {
        let goods = self.contractModel?.Products![index]
        let body = MessageBodyModel()
        if self.contractModel?.MessageBody?.ContractAgreement == nil {
            return
        }else{
            body.ContractState = self.contractModel?.MessageBody?.ContractAgreement?.ContractState
            body.ImageUrl = self.contractModel?.MessageBody?.ContractAgreement?.ImageUrl
            body.Text = self.contractModel?.MessageBody?.ContractAgreement?.Text
            body.IsIncludeTax = self.contractModel?.MessageBody?.ContractAgreement?.IsIncludeTax
            body.ContractType = self.contractModel?.MessageBody?.ContractAgreement?.ContractType
            body.Image = self.contractModel?.MessageBody?.ContractAgreement?.Image
        }
        
        body.Type = "MutilePart"
        body.Contract = self.orderModel?.ContractNo
        body.Url = String(format: "%@%@/%@", arguments: [self.contractModel?.MessageBody?.ContractAgreement?.Url ?? "",self.orderModel?.ContractNo ?? "",goods?.MainGoodsCode ?? ""])
        self.sendBlock!(body)
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
extension STMessaegOrderDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if self.orderModel?.ProductList == nil {
            return 0
        }
        return (self.orderModel?.ProductList?.count)! + 2
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
        if indexPath.row == 0 {
            let cell = STOrderTopCell.init(style: .default, reuseIdentifier: STOrderListViewController.OrderTopCell)
            cell.selectionStyle = .none
            cell.setData(model:self.orderDataList![0])
            return cell
        }else{
            if indexPath.row != ((self.orderModel?.ProductList?.count)!+1) {
                let cell = STMessageOrderItemCell.init(style: .default, reuseIdentifier: STMessaegOrderDetailViewController.MessaegOrderItemCell)
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.setData(model:(self.orderModel?.ProductList![indexPath.row-1])!)
                cell.protocolButton?.rx.tap.subscribe(onNext: { [weak self] in
                    self?.goSendProtocolVC(index: indexPath.row-1)
                }).disposed(by: disposeBag)
                return cell
            }else{
                let cell = STMessageOrderBottomCell.init(style: .default, reuseIdentifier: STMessaegOrderDetailViewController.MessaegOrderBottomCell, orderType: orderType!)
                cell.selectionStyle = .none
                cell.backgroundColor = .white
                cell.setData(model: self.orderModel!)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return TableViewHeaderNone
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return HeightRate(actureValue: 28)
        }else{
            if indexPath.row != ((self.orderModel?.ProductList?.count)!+1){
                let productModel = self.orderModel?.ProductList![indexPath.row-1]
                let textMaxSize = CGSize(width: WidthRate(actureValue: 180), height: CGFloat(MAXFLOAT))
                let size = productModel?.GoodsExplain?.boundingRect(with:textMaxSize , options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : AdaptFont(actureValue: 13)], context: nil).size
                let height = (size?.height)! + HeightRate(actureValue: 40)
                let addServersHeight = (productModel?.AddServiceInfo?.count)! * 14 + 10
                if height > HeightRate(actureValue: 111){
                    return (height + HeightRate(actureValue: CGFloat(addServersHeight))+HeightRate(actureValue: 65))
                }else{
                    return (HeightRate(actureValue: 111) + HeightRate(actureValue: CGFloat(addServersHeight))+HeightRate(actureValue: 65))
                }
            }else{
                return HeightRate(actureValue: 70)
            }
        }
    }
}
