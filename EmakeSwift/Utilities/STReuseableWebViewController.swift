//
//  STReuseableWebViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import WebKit
enum WebViewType : String{
    case instruction = "使用说明"
    case contractPreview = "预览合同"
    case protocolPreview = "技术协议"
    case saleContract = "买卖合同"
    case totalContract = "完整合同"
}
class STReuseableWebViewController: BaseViewController {
    
    typealias SendProtocolBlock = (MessageBodyModel?) -> Void
    var webViewType : WebViewType?
    var url : String = ""
    var rightButtonTitle : String?
    var messageBody : MessageBodyModel?
    var sendBlock : SendProtocolBlock?
    lazy var webView : WKWebView = {
        let webView = WKWebView()
        let requset = URLRequest(url: URL(string:self.url)!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        webView.load(requset)
        return webView
    }()
    
    lazy var progressView : UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseSetNavLeftButtonIsBack()
        switch self.webViewType {
        case .instruction?:
            self.title = webViewType?.rawValue
        case .contractPreview?:
            self.title = webViewType?.rawValue
        case .protocolPreview?:
            self.title = webViewType?.rawValue
        case .saleContract?:
            self.title = webViewType?.rawValue
        case .totalContract?:
            self.title = webViewType?.rawValue
        default:
            self.title = ""
        }
        if self.rightButtonTitle != nil {
            self.baseSetNavRightButtonWithTitle("发送")
        }
        // Do any additional setup after loading the view.
    }
    
    override func baseNavRightButtonPressed(_ button: UIButton) {
        
        self.sendBlock!(self.messageBody)
    }

    override func configSubviews() {
    
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.backgroundColor = .red
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.view.addSubview(self.webView)
        
        self.view.addSubview(self.progressView)
    }
    
    override func snapSubviews() {
        
        self.webView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        self.progressView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(2)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let newprogress = change?[.newKey] as! NSNumber
            print(newprogress)
            if newprogress == 1 {
                self.progressView.isHidden = true
                self.progressView.setProgress(0, animated: false)
            }else{
                self.progressView.isHidden = false
                self.progressView.setProgress(newprogress.floatValue, animated: false)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension STReuseableWebViewController : WKUIDelegate,WKNavigationDelegate{
    
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController.init(title: "提示", message: "提交成功", preferredStyle: .alert)
        let cancle = UIAlertAction.init(title: "确定", style: .cancel) { (action) in
            self.webView.reload()
        }
        alert.addAction(cancle)
        self.present(alert, animated: true, completion: nil)
        completionHandler()
    }
}
