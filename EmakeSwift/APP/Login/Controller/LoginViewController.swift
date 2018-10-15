//
//  LoginViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/4/10.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Toast
import RxSwift
import RxCocoa
class LoginViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()
    var phoneNumber = UITextField()
    var password = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func configSubviews() {
        let logoImage = UIImageView(image: UIImage(named:"login_logo"))
        logoImage.contentMode = .scaleAspectFit
        self.view.addSubview(logoImage)
        
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(HeightRate(actureValue: 78))
            make.width.equalTo(WidthRate(actureValue: 150))
            make.height.equalTo(150)
        }
        
        let inputView = UIView()
        inputView.backgroundColor = .white
        inputView.layer.cornerRadius = WidthRate(actureValue: 5)
        self.view.addSubview(inputView)
        
        inputView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.left.equalTo(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: -15))
            make.height.equalTo(HeightRate(actureValue: 135))
            make.top.equalTo(logoImage.snp.bottom).offset(HeightRate(actureValue: 30))
        }
        
        let phoneNumberImage = UIImageView(image:UIImage(named:"login_phone number"))
        phoneNumberImage.contentMode = .scaleAspectFit
        inputView.addSubview(phoneNumberImage)
        
        phoneNumberImage.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: WidthRate(actureValue: 12)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(HeightRate(actureValue: 25))
        }
        
        let passwordImage = UIImageView(image:UIImage(named:"login_password"))
        passwordImage.contentMode = .scaleAspectFit
        inputView.addSubview(passwordImage)
        
        passwordImage.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: WidthRate(actureValue: 12)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(phoneNumberImage.snp.bottom).offset(HeightRate(actureValue: 35))
        }
        
        
        phoneNumber.keyboardType = .phonePad
        phoneNumber.clearButtonMode = .never
        phoneNumber.placeholder = "请输入手机号码"
        phoneNumber.font = AdaptFont(actureValue: 16)
        inputView.addSubview(phoneNumber)
        
        phoneNumber.snp.makeConstraints { (make) in
            make.centerY.equalTo(phoneNumberImage.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 35))
            make.left.equalTo(phoneNumberImage.snp.right).offset(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -10)))
        }
        
        password.clearButtonMode = .whileEditing
        password.placeholder = "请输入密码"
        password.font = AdaptFont(actureValue: 16)
        password.isSecureTextEntry = true
        inputView.addSubview(password)
        
        password.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordImage.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 35))
            make.left.equalTo(passwordImage.snp.right).offset(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -85)))
        }
        
        let line = UILabel()
        line.backgroundColor = BaseColor.SepratorLineColor
        inputView.addSubview(line)
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 10))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(1.5)
            make.centerY.equalTo(inputView.snp.centerY)
        }
        
        
        let lineAnother = UILabel()
        lineAnother.backgroundColor = BaseColor.SepratorLineColor
        inputView.addSubview(lineAnother)
        
        lineAnother.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 10))
            make.right.equalTo(WidthRate(actureValue: -10))
            make.height.equalTo(1.5)
            make.bottom.equalTo(inputView.snp.bottom).offset(HeightRate(actureValue: -5))
        }
        
        let passwordSecurityBtn = UIButton(type: .custom)
        passwordSecurityBtn.setImage(UIImage(named:"login_eyes_closed"), for: .normal)
        passwordSecurityBtn.setImage(UIImage(named:"login_eyes_opend"), for: .selected)
        passwordSecurityBtn.addTarget(self, action: #selector(securityOption(_:)), for: .touchUpInside)
        inputView.addSubview(passwordSecurityBtn)
        
        passwordSecurityBtn.snp.makeConstraints { (make) in
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -20)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(WidthRate(actureValue: 25))
            make.centerY.equalTo(passwordImage.snp.centerY)
        }
        
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登 录", for: .normal)
        loginButton.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = AdaptFont(actureValue: 18)
        loginButton.layer.cornerRadius = WidthRate(actureValue: 6)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(WidthRate(actureValue: 300))
            make.height.equalTo(HeightRate(actureValue: 45))
            make.top.equalTo(inputView.snp.bottom).offset(HeightRate(actureValue: 65))
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        let lineV = UILabel()
        lineV.backgroundColor = BaseColor.SepratorLineColor
        self.view.addSubview(lineV)
        
        lineV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(loginButton.snp.bottom).offset(HeightRate(actureValue: 20))
            make.height.equalTo(HeightRate(actureValue: 15))
            make.width.equalTo(1.5)
        }
        
        let registerBtn = UIButton(type: .custom)
        registerBtn.setTitle("立即注册", for: .normal)
        registerBtn.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        registerBtn.titleLabel?.font = AdaptFont(actureValue: 14)
        registerBtn.addTarget(self, action: #selector(goRegisterVC), for: .touchUpInside)
        self.view.addSubview(registerBtn)
        
        
        registerBtn.snp.makeConstraints { (make) in
            make.width.equalTo(WidthRate(actureValue: 60))
            make.right.equalTo(lineV.snp.left).offset(WidthRate(actureValue: -10))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.centerY.equalTo(lineV.snp.centerY)
        }
        
        let passwordForgotenBtn = UIButton(type: .custom)
        passwordForgotenBtn.setTitle("忘记密码", for: .normal)
        passwordForgotenBtn.setTitleColor(BaseColor.APP_THEME_MAIN_COLOR, for: .normal)
        passwordForgotenBtn.titleLabel?.font = AdaptFont(actureValue: 14)
        passwordForgotenBtn.addTarget(self, action: #selector(goPasswordForgotenVC), for: .touchUpInside)
        self.view.addSubview(passwordForgotenBtn)
        
        
        passwordForgotenBtn.snp.makeConstraints { (make) in
            make.width.equalTo(WidthRate(actureValue: 75))
            make.left.equalTo(lineV.snp.right).offset(WidthRate(actureValue: 10))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.centerY.equalTo(lineV.snp.centerY)
        }
    }
  
    @objc func securityOption(_ button:UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected {
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    @objc func login(){
        
        self.view.endEditing(true)
        if phoneNumber.text == nil || phoneNumber.text?.count == 0{
            self.view.makeToast("请输入账号", duration: 1.0, position: CSToastPositionBottom)
            return
        }
        if password.text == nil || password.text?.count == 0{
            self.view.makeToast("请输入登录密码", duration: 1.0, position: CSToastPositionBottom)
            return
        }
        //登录: 密码"+":emake" MD5加密
        let passwordString  = self.password.text! + ":emake"
        let passwordMD5String = Tools.md5String(str: passwordString)
        let parameters: NSDictionary  = ["MobileNumber":self.phoneNumber.text!,"Password":passwordMD5String,"client_id":EmakeStore]
        viewModel.login(self, parameters: parameters,successBlock: { model in
            let loginModel = model as! LoginModel
            UserDefaults.standard.set(loginModel.access_token, forKey: EmakeToken)
            UserDefaults.standard.set(loginModel.refresh_token, forKey: EmakeRefreshToken)
            UserDefaults.standard.set(loginModel.userinfo?.HeadImageUrl, forKey: EmakeHeadImageUrlString)
            UserDefaults.standard.set(loginModel.userinfo?.MobileNumber, forKey: EmakeUserPhoneNumber)
            UserDefaults.standard.set(loginModel.userinfo?.RealName, forKey: EmakeUserRealName)
            UserDefaults.standard.set(loginModel.userinfo?.NickName, forKey: EmakeUserNickName)
            UserDefaults.standard.set(loginModel.userinfo?.UserId, forKey: EmakeUserId)
            UserDefaults.standard.set(loginModel.userinfo?.BusinessCategory, forKey: EmakeUserBusinessCategory)
            UserDefaults.standard.set(loginModel.userinfo?.ServiceID, forKey: EmakeUserServiceID)
            UserDefaults.standard.synchronize()
            //延迟一秒
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.getStoreInfo(serverId:(loginModel.userinfo?.ServiceID)!)
            })
        })
    }
    
    func getStoreInfo(serverId:String) {
        
        viewModel.getStoreInfo(self) { (model) in
            let storeModel = model as! StoreModel
            UserDefaults.standard.set(storeModel.StoreId, forKey: EmakeStoreId)
            UserDefaults.standard.set(storeModel.CategoryBId, forKey: EmakeStoreCategoryBId)
            UserDefaults.standard.set(storeModel.CategoryBName, forKey: EmakeStoreCategoryBName)
            UserDefaults.standard.set(storeModel.StorePhoto, forKey: EmakeStorePhoto)
            UserDefaults.standard.set(storeModel.StoreName, forKey: EmakeStoreName)
            UserDefaults.standard.set(storeModel.StoreType, forKey: EmakeStoreType)
            UserDefaults.standard.set(storeModel.StoreState, forKey: EmakeStoreState)
            UserDefaults.standard.synchronize()
            MQTTClientDefault.shared().connectToHost(withServerId: serverId,storeID:storeModel.StoreId!)
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationLoginRefresh), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func goRegisterVC(){
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @objc func goPasswordForgotenVC(){
        let passwordVC = PasswordForgetViewController()
        self.navigationController?.pushViewController(passwordVC, animated: true)
    }
    override func didReceiveMemoryWarning(){
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
