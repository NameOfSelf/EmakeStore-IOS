//
//  STOrderListViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/5.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import HTHorizontalSelectionList
import MJRefresh
import RxSwift
import RxCocoa
import Toast
class STOrderListViewController: BaseViewController {
    
    var selctionList : HTHorizontalSelectionList?
    let titles = ["全部","待签订","待付款","生产中","生产完成","已发货"]
    var table : UITableView?
    var selectIndex : NSInteger? = 0
    var pageNumber : NSInteger? = 1
    var isMaxPage : Bool? = false
    let viewModel = STOrderListViewModel()
    var orderDataList : [STOrderModel]? = []
    static let OrderTopCell = "OrderTopCell"
    static let OrderItemCell = "OrderItemCell"
    static let OrderBottomCell = "OrderBottomCell"
    let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单"
        self.baseSetNavRightButtonWithImage("yizhizaokefu")
        // Do any additional setup after loading the view.
    }
    
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        self.sendStoreServerList()
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        let serverID = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        vc.userId = serverID
        if UserDefaults.standard.object(forKey: EmakeUserNickName) != nil {
            vc.userName = UserDefaults.standard.object(forKey: EmakeUserNickName) as? String
        }else{
            vc.userName = ""
        }
        if UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) != nil {
            vc.userAvatar = UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) as? String
        }else{
            vc.userAvatar = ""
        }
        if UserDefaults.standard.object(forKey: EmakeUserPhoneNumber) != nil {
            vc.userPhone = UserDefaults.standard.object(forKey: EmakeUserPhoneNumber) as? String
        }else{
            vc.userPhone = ""
        }
        vc.userType = ""
        vc.isChatWithOffcial = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func configSubviews() {
        
        self.selctionList = HTHorizontalSelectionList(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: HeightRate(actureValue: 44)))
        self.selctionList?.delegate = self
        self.selctionList?.dataSource = self
        self.selctionList?.snapToCenter = true
        self.selctionList?.setTitleColor(.black, for: .normal)
        self.selctionList?.selectionIndicatorColor = BaseColor.APP_THEME_MAIN_COLOR
        self.selctionList?.bottomTrimColor = BaseColor.SepratorLineColor
        self.view.addSubview(self.selctionList!)
        
        
        self.table = UITableView(frame: .zero, style: .grouped)
        self.table?.delegate = self
        self.table?.dataSource = self
        self.table?.separatorStyle = .none
        self.table?.estimatedSectionFooterHeight = TableViewFooterNone
        self.table?.estimatedSectionHeaderHeight = TableViewHeaderNone
        self.table?.backgroundColor = .clear
        self.table?.headerRefresh(block: {
            self.tableViewHeaderRefresh(index: self.selectIndex!)
        })
        self.table?.mj_header.beginRefreshing()
        self.table?.footerRefresh(block: {
            self.tableViewFooterRefresh(index: self.selectIndex!)
        })
        self.view.addSubview(self.table!)
    }
    
    
    
    override func snapSubviews() {
        
        self.selctionList?.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(HeightRate(actureValue: 44))
        })
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo((self.selctionList?.snp.bottom)!)
        })
    }
    func tableViewHeaderRefresh(index:NSInteger) {
        
        self.selectIndex = index
        self.pageNumber = 1
        var RequestType = ""
        if index == 0{
            RequestType = "1"
        }
        var OrderState = ""
        switch index {
        case 1:
            OrderState = "-2"
        case 2:
            OrderState = "0"
        case 3:
            OrderState = "1"
        case 4:
            OrderState = "2"
        case 5:
            OrderState = "3"
        default:
            break
        }
        self.table?.mj_footer.resetNoMoreData()
        self.isMaxPage = false
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId)
        var parameters: NSDictionary?
        if index == 0 {
            parameters = ["StoreId":storeId!,"PageIndex":self.pageNumber!,"PageSize":5,"RequestType":RequestType,"OrderState":""]
        }else{
            parameters = ["StoreId":storeId!,"PageIndex":self.pageNumber!,"PageSize":5,"RequestType":RequestType,"OrderState":OrderState]
        }
        viewModel.getOrderList(self, parameters: parameters!, successBlock: { (orderList) in
            self.orderDataList = orderList as? [STOrderModel]
            self.table?.mj_header.endRefreshing()
            self.table?.reloadData()
        }) { (error) in
            self.table?.mj_header.endRefreshing()
        }
    }
    
    func tableViewFooterRefresh(index:NSInteger) {
        self.pageNumber = self.pageNumber! + 1
        var RequestType = ""
        if index == 0{
            RequestType = "1"
        }
        var OrderState = ""
        switch index {
        case 1:
            OrderState = "-2"
        case 2:
            OrderState = "0"
        case 3:
            OrderState = "1"
        case 4:
            OrderState = "2"
        case 5:
            OrderState = "3"
        default:
            break
        }
        if self.isMaxPage! {
            self.table?.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId)
        var parameters: NSDictionary?
        if index == 0 {
            parameters = ["StoreId":storeId!,"PageIndex":self.pageNumber!,"PageSize":5,"RequestType":RequestType,"OrderState":""]
        }else{
            parameters = ["StoreId":storeId!,"PageIndex":self.pageNumber!,"PageSize":5,"RequestType":RequestType,"OrderState":OrderState]
        }
        viewModel.getOrderList(self, parameters: parameters!, successBlock: { (orderList) in
            let orders = orderList as! [STOrderModel]
            if orders.count < 5{
                self.isMaxPage = true
                self.table?.mj_footer.endRefreshingWithNoMoreData()
            }
            self.orderDataList?.append(contentsOf: orders)
            self.table?.reloadData()
            self.table?.mj_footer.endRefreshing()
        }) { (error) in
            self.pageNumber = self.pageNumber! - 1
            self.table?.mj_footer.endRefreshing()
        }
    }
    
    func getContractPDF(contractNo:String) {
        let vc = STReuseableWebViewController()
        vc.url = String(format: "%@/%@", arguments: [WebViewURL.ContractURL.rawValue,contractNo])
        vc.webViewType = .contractPreview
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendStoreServerList() {
        
        let ServerListCMD = CommandModel.creatChatroomCustomerListCMD()
        MQTTClientDefault.shared().sendMessage(withMessage: ServerListCMD, topic: MQTT_CMDTopic) { (error) in
        }
    }
    
    
    func goChatVC(orderModel:STOrderModel) {
        
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + (orderModel.UserId)!
        MQTTClientDefault.shared().subcribeTo(topic: topic)
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        vc.userId = orderModel.UserId
        if orderModel.RealName == nil {
            vc.userName = "用户" + (orderModel.MobileNumber![(orderModel.MobileNumber?.count)!-4..<(orderModel.MobileNumber?.count)!])
        }else{
            vc.userName = orderModel.RealName
        }
        vc.userAvatar = orderModel.HeadImageUrl
        vc.userPhone = orderModel.MobileNumber
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
extension STOrderListViewController : HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource{
    
    func selectionList(_ selectionList: HTHorizontalSelectionList, didSelectButtonWith index: Int) {
        
        self.tableViewHeaderRefresh(index: index)
    }
    
    func numberOfItems(in selectionList: HTHorizontalSelectionList) -> Int {
        
        return self.titles.count
    }
    
    func selectionList(_ selectionList: HTHorizontalSelectionList, titleForItemWith index: Int) -> String? {
        
        return self.titles[index]
    }
}

extension STOrderListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (self.orderDataList?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let orderModel = self.orderDataList![section]
        if (orderModel.ProductList?.count)! >= 2 {
            return 4
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let orderModel = self.orderDataList![indexPath.section]
        var orderType : OrderType?
        if orderModel.OrderState == "0"{
            orderType = .待付款
        }else if orderModel.OrderState == "1"{
            orderType = .生产中
        }else if orderModel.OrderState == "2"{
            orderType = .生产完成
        }else if orderModel.OrderState == "3"{
            orderType = .已发货
        }else if orderModel.OrderState == "-2"{
            orderType = .待签订
        }
        switch indexPath.row {
        case 0:
            let cell = STOrderTopCell.init(style: .default, reuseIdentifier: STOrderListViewController.OrderTopCell)
            cell.selectionStyle = .none
            cell.setData(model:self.orderDataList![indexPath.section])
            return cell
        case 3:
            let cell = STOrderBottomCell.init(style: .default, reuseIdentifier: STOrderListViewController.OrderBottomCell, orderType: orderType!)
            cell.setData(model:orderModel)
            cell.selectionStyle = .none
            cell.lookUpContractButton?.rx.tap.subscribe(onNext: { [weak self] in
                self?.getContractPDF(contractNo: orderModel.ContractNo ?? "")
            }).disposed(by: disposeBag)
            cell.contractChatButton?.rx.tap.subscribe(onNext: { [weak self] in
                self?.goChatVC(orderModel: orderModel)
            }).disposed(by: disposeBag)
            return cell
        case 2:
            if (orderModel.ProductList?.count)! >= 2 {
                let cell = STOrderItemCell.init(style: .default, reuseIdentifier: STOrderListViewController.OrderItemCell)
                cell.setData(model:orderModel.ProductList![indexPath.row-1])
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = STOrderBottomCell.init(style: .default, reuseIdentifier: STOrderListViewController.OrderBottomCell, orderType: orderType!)
                let orderModel = self.orderDataList![indexPath.section]
                cell.selectionStyle = .none
                cell.setData(model:self.orderDataList![indexPath.section])
                cell.lookUpContractButton?.rx.tap.subscribe(onNext: { [weak self] in
                    self?.getContractPDF(contractNo: orderModel.ContractNo ?? "")
                }).disposed(by: disposeBag)
                cell.contractChatButton?.rx.tap.subscribe(onNext: { [weak self] in
                    self?.goChatVC(orderModel: orderModel)
                }).disposed(by: disposeBag)
                return cell
            }
        default:
            let cell = STOrderItemCell.init(style: .default, reuseIdentifier: STOrderListViewController.OrderItemCell)
            cell.setData(model:orderModel.ProductList![indexPath.row-1])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return HeightRate(actureValue: 28)
        case 1:
            let orderModel = self.orderDataList![indexPath.section]
            let productModel = orderModel.ProductList![indexPath.row-1]
            let textMaxSize = CGSize(width: WidthRate(actureValue: 180), height: CGFloat(MAXFLOAT))
            let width = productModel.GoodsExplain?.boundingRect(with:textMaxSize , options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : AdaptFont(actureValue: 13)], context: nil).size
            let height = (width?.height)!+HeightRate(actureValue: 50)
            if height > HeightRate(actureValue: 111){
                return height
            }else{
                return HeightRate(actureValue: 111)
            }
        case 2:
            let orderModel = self.orderDataList![indexPath.section]
            if (orderModel.ProductList?.count)! >= 2 {
                let productModel = orderModel.ProductList![indexPath.row-1]
                let textMaxSize = CGSize(width: WidthRate(actureValue: 180), height: CGFloat(MAXFLOAT))
                let width = productModel.GoodsExplain?.boundingRect(with:textMaxSize , options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : AdaptFont(actureValue: 13)], context: nil).size
                let height = (width?.height)!+HeightRate(actureValue: 50)
                if height > HeightRate(actureValue: 111){
                    return height
                }else{
                    return HeightRate(actureValue: 111)
                }
            }else{
                if orderModel.OrderState == "-2"{
                    return HeightRate(actureValue: 93)
                }else{
                    return HeightRate(actureValue: 128)
                }
            }
        default:
            let orderModel = self.orderDataList![indexPath.section]
            if orderModel.OrderState == "-2"{
                return HeightRate(actureValue: 93)
            }else{
                return HeightRate(actureValue: 128)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return TableViewFooterNone
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderModel = self.orderDataList![indexPath.section]
        let vc = STOrderDetailViewController()
        vc.orderModel = orderModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
