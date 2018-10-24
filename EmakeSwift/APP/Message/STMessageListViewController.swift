//
//  STMessageListViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/5.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RealmSwift
import RxCocoa
import RxSwift

class STMessageListViewController: BaseViewController {
    
    var responseList : [MessageModel]? = []
    var messageList : Results<RealmChatListData>?
    var table : UITableView?
    let viewModel = STMessageListViewModel()
    let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: EmakeStoreName) != nil {
            self.navigationItem.title = UserDefaults.standard.object(forKey: EmakeStoreName) as? String
        }
        if UserDefaults.standard.object(forKey: EmakeUserServiceID) != nil {
            self.messageList = RealmChatTool.getAllChatListData()
            self.table?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseSetNavLeftButtonWithImage("icon_service")
        self.baseSetNavRightButtonWithImage("icon_message")        
        if UserDefaults.standard.object(forKey: EmakeToken) == nil{
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        if UserDefaults.standard.object(forKey: EmakeUserServiceID) != nil {
            self.sendStoreServiceUserList()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(sendStoreServiceUserList), name: NSNotification.Name(rawValue: NotificationLoginRefresh), object: nil)
        // Do any additional setup after loading the view.
    }
    
    //平台客服入口
    override func baseNavLeftButtonPressed(_ button: UIButton) {
        self.sendStoreServerList()
        
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        let serverID = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        vc.userId = serverID
        vc.userName = serverID;
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
        vc.title = "平台客服"
        vc.userRemarkName = ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        
        let vc = STMessageSystemViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configSubviews() {
        
        self.table = UITableView(frame: .zero, style: .grouped)
        self.table?.delegate = self;
        self.table?.dataSource = self;
        self.table?.showsVerticalScrollIndicator = false
        self.table?.showsHorizontalScrollIndicator = false
        self.table?.separatorColor = .clear;
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

    //平台客服入口
    func goChatVC(userModel:RealmChatListData) {
        
        let part = userModel.clientId?.components(separatedBy: "/")
        if part?.count != 2{
            return
        }
        let userId = part![1]
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let clientSelf = "user/" + serverId
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        vc.userId = userId
        if userModel.userName?.count == nil{
            if userModel.userPhone != nil{
                vc.userName = "用户" + userModel.userPhone![(userModel.userPhone?.count)!-4..<(userModel.userPhone?.count)!]
            }
        }else{
            vc.userName = userModel.userName
        }
        vc.userAvatar = userModel.userAvata
        vc.userPhone = userModel.userPhone
        vc.userRemarkName = userModel.userRemarkName
        vc.userId = userId
        vc.userType = userModel.userType
        vc.endBlock = { [weak self] text in
            let deleteClientId = "user/" + text
            RealmChatTool.deleteChatListData(with: deleteClientId)
            self?.messageList = RealmChatTool.getAllChatListData()
            self?.table?.reloadData()
        }
        if clientSelf == userModel.clientId {
            vc.userName = "平台客服"
            vc.isChatWithOffcial = true
            vc.userRemarkName = ""
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //用户
    func goChatVC(with message:MessageModel,index:NSInteger,userRemarkName:String) {
        
        self.responseList?.remove(at: index)
        let chatList = RealmChatListData()
        chatList.userName = message.From?.DisplayName ?? ""
        chatList.userAvata = message.From?.Avatar ?? ""
        chatList.userPhone = message.From?.PhoneNumber ?? ""
        chatList.userType = message.From?.UserType
        chatList.userRemarkName = userRemarkName
        chatList.messageCount = "0"
        chatList.clientId = message.From?.ClientID
        chatList.message =  message.MessageBody?.Text ?? ""
        chatList.sendTime = String(format: "%d", [message.Timestamp])
        chatList.groupInfo = message.From?.Group ?? ""
        chatList.messageType = message.MessageBody?.Type
        RealmChatTool.insertChatListData(by: chatList)
        self.messageList = RealmChatTool.getAllChatListData()
        self.table?.reloadData()
        
        let part = message.From?.ClientID?.components(separatedBy: "/")
        if part?.count != 2{
            return
        }
        let userId = part![1]
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + userId
        MQTTClientDefault.shared().subcribeTo(topic: topic)
        self.sendCustomerAcceptService(userId: userId)
        let storyboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Chat") as! STChatViewController
        vc.userId = userId
        if message.From?.DisplayName?.count == nil{
            if message.From?.PhoneNumber != nil{
                vc.userName = "用户" + (message.From?.PhoneNumber![(message.From?.PhoneNumber?.count)!-4..<(message.From?.PhoneNumber?.count)!])!
            }
        }else{
            vc.userName = message.From?.DisplayName
        }
        vc.endBlock = { [weak self] text in
            let deleteClientId = "user/" + text
            RealmChatTool.deleteChatListData(with: deleteClientId)
            self?.messageList = RealmChatTool.getAllChatListData()
            self?.table?.reloadData()
        }
        vc.userAvatar = message.From?.Avatar
        vc.userPhone = message.From?.PhoneNumber
        vc.userType = message.From?.UserType
        vc.userRemarkName = userRemarkName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getUserInfo(with userID:String,message:MessageModel,index:NSInteger) {
        
        let parameters : NSDictionary? = ["UserId":userID]
        viewModel.getUserInfo(self, parameters: parameters!, successBlock: { (model) in
            let userInfo = model as! STMesageListUserInfoModel
            var userRemarkName : String?
            if (userInfo.RemarkName == nil ||  userInfo.RemarkName?.count == 0) && (userInfo.RemarkCompany == nil ||  userInfo.RemarkCompany?.count == 0){
                userRemarkName = ""
            }else{
                userRemarkName = String(format: "%@ %@", arguments: [userInfo.RemarkCompany ?? "",userInfo.RemarkName ?? ""])
            }
            self.goChatVC(with: message, index: index, userRemarkName: userRemarkName!)
        }) { (error) in
            
        }
    }
    
    
    func sendStoreServerList() {
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let MQTT_CMDTopic = String(format: "customer/%@/%@", arguments: [storeId,serverId])
        let ServerListCMD = CommandModel.creatChatroomCustomerListCMD()
        MQTTClientDefault.shared().sendMessage(withMessage: ServerListCMD, topic: MQTT_CMDTopic) { (error) in
        }
    }
    
    
    func sendCustomerAcceptService(userId:String) {
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let MQTT_CMDTopic = String(format: "customer/%@/%@", arguments: [storeId,serverId])
        let ServerListCMD = CommandModel.creatCustomerAcceptService(userId: userId)
        MQTTClientDefault.shared().sendMessage(withMessage: ServerListCMD, topic: MQTT_CMDTopic) { (error) in
        }
    }
    
    @objc func sendStoreServiceUserList() {
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let serverId = UserDefaults.standard.object(forKey: EmakeUserServiceID) as! String
        let MQTT_CMDTopic = String(format: "customer/%@/%@", arguments: [storeId,serverId])
        let ServerListCMD = CommandModel.creatStoreServiceUserList()
        MQTTClientDefault.shared().sendMessage(withMessage: ServerListCMD, topic: MQTT_CMDTopic) { (error) in
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
extension STMessageListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            if self.responseList == nil {
                return 0
            }
            return self.responseList!.count
        }else{
            if self.messageList == nil {
                return 0
            }
            return self.messageList!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = STMessageResponseTableViewCell.init(style: .default, reuseIdentifier: "ResponseCell")
            cell.selectionStyle = .none
            let message = self.responseList![indexPath.row]
            cell.setData(data: message)
            cell.responseButton?.rx.tap.subscribe(onNext: { [weak self] in
                self?.getUserInfo(with: message.From?.UserId ?? "",message: message,index: indexPath.row)
            }).disposed(by: disposeBag)
            return cell
        }else{
            let cell = STMessageListTableViewCell.init(style: .default, reuseIdentifier: "ListCell")
            cell.selectionStyle = .none
            let data = self.messageList![indexPath.row]
            cell.setData(data: data)
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return TableViewHeaderNone
        }else{
            return HeightRate(actureValue: 5)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return HeightRate(actureValue: 75)
        }else{
            return HeightRate(actureValue: 65)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            self.messageList = RealmChatTool.getAllChatListData()
            let model = self.messageList![indexPath.row]
            self.goChatVC(userModel: model)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section == 1 {
            return .delete
        }else{
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let model = self.messageList![indexPath.row]
            RealmChatTool.deleteChatListData(with: model.clientId!)
            self.messageList = RealmChatTool.getAllChatListData()
            self.table?.reloadData()
        }
    }
}
