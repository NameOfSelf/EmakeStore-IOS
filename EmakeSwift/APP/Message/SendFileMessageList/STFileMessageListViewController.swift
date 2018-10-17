//
//  STFileMessageListViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/16.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import RealmSwift

class STFileMessageListViewController: BaseViewController {

    var fileName:String?
    var filePath:String?
    var fileData:Data?
    var messageList : Results<RealmChatListData>?
    var table : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择一个聊天"
        self.baseSetNavLeftButtonIsBack()
        if UserDefaults.standard.object(forKey: EmakeToken) == nil{
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        if UserDefaults.standard.object(forKey: EmakeUserServiceID) != nil {
            self.messageList = RealmChatTool.getAllChatListData()
            self.table?.reloadData()
        }
        // Do any additional setup after loading the view.
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
extension STFileMessageListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.messageList == nil {
            return 0
        }
        return self.messageList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = STMessageListTableViewCell.init(style: .default, reuseIdentifier: "ListCell")
        cell.selectionStyle = .none
        let data = self.messageList![indexPath.row]
        cell.setData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return HeightRate(actureValue: 5)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return HeightRate(actureValue: 65)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.messageList = RealmChatTool.getAllChatListData()
        let model = self.messageList![indexPath.row]
        self.goChatVC(userModel: model)
    }
    
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
        vc.userId = userId
        vc.userType = userModel.userType
        vc.isUploadFile = true
        vc.filePath = self.filePath
        vc.fileName = self.fileName
        vc.fileData = self.fileData
        if clientSelf == userModel.clientId {
            vc.userName = "平台客服"
            vc.isChatWithOffcial = true
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

