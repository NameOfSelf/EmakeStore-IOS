//
//  STMineViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/5.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import SDWebImage
import Toast
class STMineViewController: BaseViewController {
    
    var table : UITableView?
    let Identifer = "cell"
    let titles = ["使用帮助","自动回复","清除缓存","退出登录"]
    let imageNames = ["icon_help","icon_Auto-responders","icon_clear cache","icon_logout"]
    var headerView : STMineTableHeaderView?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table?.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        self.navigationItem.leftBarButtonItem = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.table?.tableHeaderView = STMineTableHeaderView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: HeightRate(actureValue: 132)))
    }
    
    override func configSubviews() {
        
        self.table = UITableView(frame: .zero, style: .plain)
        self.table?.delegate = self
        self.table?.dataSource = self
        self.table?.estimatedRowHeight = 0
        self.table?.estimatedSectionHeaderHeight = 0
        self.table?.separatorStyle = .none
        self.table?.backgroundColor = .clear
        self.view.addSubview(self.table!)
    }
    
    override func snapSubviews() {
        
        self.table?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
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
extension STMineViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var type : MineCellType?
        switch indexPath.row {
        case 0,1:
            type = .RightWithImage
        case 2:
            type = .RightWithText
        default:
            type = .RightNone
        }
        let cell = STMineTableViewCell.init(style: .default, reuseIdentifier: Identifer, type: type!)
        cell.selectionStyle = .none
        cell.leftTitle?.text = self.titles[indexPath.row]
        cell.leftImage?.image = UIImage(named: imageNames[indexPath.row])
        if indexPath.row == 2 {
            let size = SDImageCache.shared().getSize()
            let sizeM = Double(size)/(1024.0*1024.0)
            cell.rightTitle?.text = String(format: "%.2fM", arguments: [sizeM])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return HeightRate(actureValue: 45)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = STReuseableWebViewController()
            vc.webViewType = .instruction
            vc.url = WebViewURL.InstuctionURL.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = STReplyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let alert = STAlertView.init(frame: CGRect(x: 0, y: 0, width: WidthRate(actureValue: 280), height: HeightRate(actureValue: 160)), title: "提示", message: "确定清理缓存", leftTitle: "取消", rightTitle: "确定")
            alert?.delegate = self;
            alert?.showAnimated()
            
        default:
            let actionSheetView = STActionSheetView.init(frame: .zero, titles: ["确定"])
            actionSheetView.delegate = self
            actionSheetView.showAnimated()
        }
    }
}

extension STMineViewController : STActionSheetViewDelegate {
    
    func clickAtIndex(index: NSInteger) {
        if index == 0 {
            UserDefaultClean()
            MQTTClientDefault.shared().disConnect()
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}
extension STMineViewController : STAlertViewDelegate {
    func alertViewLeftButtonClick() {
        
    }
    
    func alertViewRightButtonClick() {
        SDImageCache.shared().clearDisk {
            self.view.makeToast("清理缓存成功", duration: 1.0, position: CSToastPositionCenter)
            self.table?.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)
        }
    }
    
    
}

