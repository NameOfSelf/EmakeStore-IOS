//
//  RegisterViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/4/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Toast
class RegisterViewController: BaseViewController {
    
    var phoneNumber = UITextField()
    var verifyCode = UITextField()
    var password = UITextField()
    var getVerifyCodeBtn = UIButton()
    var count : NSInteger = 60
    private var timer: Timer?
    private var isCounting: Bool = false {//是否开始计时
        willSet(newValue) {
            if newValue {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    let viewModel = RegisterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        self.view.backgroundColor = .white
        self.baseSetNavLeftButtonIsBack()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func configSubviews() {
        
        let logoImageView = UIImageView(image: UIImage(named:"login_logo"))
        logoImageView.contentMode = .scaleAspectFit
        self.view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(WidthRate(actureValue: 130))
            make.height.equalTo(HeightRate(actureValue: 135))
            make.top.equalTo(HeightRate(actureValue: 15))
        }
        
        let phoneNumberImage = UIImageView(image:UIImage(named:"login_phone number"))
        phoneNumberImage.contentMode = .scaleAspectFit
        self.view.addSubview(phoneNumberImage)
        
        phoneNumberImage.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 34))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(logoImageView.snp.bottom).offset(HeightRate(actureValue: 40))
        }
        
        
        phoneNumber.keyboardType = .phonePad
        phoneNumber.clearButtonMode = .never
        phoneNumber.placeholder = "请输入手机号"
        phoneNumber.font = AdaptFont(actureValue: 16)
        self.view.addSubview(phoneNumber)
        
        phoneNumber.snp.makeConstraints { (make) in
            make.centerY.equalTo(phoneNumberImage.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 40))
            make.left.equalTo(phoneNumberImage.snp.right).offset(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: -30))
        }
        
        let line = UILabel()
        line.backgroundColor = BaseColor.SepratorLineColor
        self.view.addSubview(line)
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 32))
            make.right.equalTo(WidthRate(actureValue: -30))
            make.height.equalTo(1.5)
            make.top.equalTo(phoneNumberImage.snp.bottom).offset(HeightRate(actureValue: 18))
        }
        
        let verifyCodeImage = UIImageView(image:UIImage(named:"login_code"))
        verifyCodeImage.contentMode = .scaleAspectFit
        self.view.addSubview(verifyCodeImage)
        
        verifyCodeImage.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 34))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(phoneNumberImage.snp.bottom).offset(HeightRate(actureValue: 34))
        }
        
        
        verifyCode.clearButtonMode = .whileEditing
        verifyCode.placeholder = "请输入验证码"
        verifyCode.font = AdaptFont(actureValue: 16)
        self.view.addSubview(verifyCode)

        verifyCode.snp.makeConstraints { (make) in
            make.centerY.equalTo(verifyCodeImage.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 40))
            make.left.equalTo(verifyCodeImage.snp.right).offset(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -140)))
        }

        getVerifyCodeBtn = UIButton(type:.custom)
        getVerifyCodeBtn.setTitle("获取验证码", for: .normal)
        getVerifyCodeBtn.setTitleColor(BaseColor.LoginPasswordForgotenColor, for: .normal)
        getVerifyCodeBtn.layer.borderColor = BaseColor.APP_THEME_MAIN_COLOR.cgColor
        getVerifyCodeBtn.layer.borderWidth = 1
        getVerifyCodeBtn.layer.cornerRadius = WidthRate(actureValue: 4)
        getVerifyCodeBtn.titleLabel?.font = AdaptFont(actureValue: 12)
        getVerifyCodeBtn.addTarget(self, action: #selector(getCode), for: .touchUpInside)
        self.view.addSubview(getVerifyCodeBtn)

        getVerifyCodeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(WidthRate(actureValue: 75))
            make.height.equalTo(HeightRate(actureValue: 27))
            make.right.equalTo((WidthRate(actureValue: -30)))
            make.centerY.equalTo(verifyCode.snp.centerY)
        }

        let lineAnother = UILabel()
        lineAnother.backgroundColor = BaseColor.SepratorLineColor
        self.view.addSubview(lineAnother)

        lineAnother.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 34))
            make.right.equalTo(WidthRate(actureValue: -30))
            make.height.equalTo(1.5)
            make.top.equalTo(verifyCodeImage.snp.bottom).offset(HeightRate(actureValue: 18))
        }

        let passwordImage = UIImageView(image:UIImage(named:"login_password"))
        passwordImage.contentMode = .scaleAspectFit
        self.view.addSubview(passwordImage)

        passwordImage.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: WidthRate(actureValue: 34)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(verifyCodeImage.snp.bottom).offset(HeightRate(actureValue: 34))
        }


        password.clearButtonMode = .whileEditing
        password.placeholder = "请输入密码"
        password.font = AdaptFont(actureValue: 16)
        password.isSecureTextEntry = true
        self.view.addSubview(password)

        password.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordImage.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 40))
            make.left.equalTo(passwordImage.snp.right).offset(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -75)))
        }


        let passwordSecurityBtn = UIButton(type: .custom)
        passwordSecurityBtn.setImage(UIImage(named:"login_eyes_closed"), for: .normal)
        passwordSecurityBtn.setImage(UIImage(named:"login_eyes_opend"), for: .selected)
        passwordSecurityBtn.addTarget(self, action: #selector(securityOption(_:)), for: .touchUpInside)
        self.view.addSubview(passwordSecurityBtn)

        passwordSecurityBtn.snp.makeConstraints { (make) in
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -30)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(WidthRate(actureValue: 25))
            make.centerY.equalTo(passwordImage.snp.centerY)
        }
        
        
        let lineFour = UILabel()
        lineFour.backgroundColor = BaseColor.SepratorLineColor
        self.view.addSubview(lineFour)
        
        lineFour.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 34))
            make.right.equalTo(WidthRate(actureValue: -30))
            make.height.equalTo(1.5)
            make.top.equalTo(passwordImage.snp.bottom).offset(HeightRate(actureValue: 18))
        }
        
        let confirmButton = UIButton(type:.custom)
        confirmButton.setTitle("注 册", for: .normal)
        confirmButton.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = AdaptFont(actureValue: 16)
        confirmButton.layer.cornerRadius = WidthRate(actureValue: 6)
        confirmButton.addTarget(self, action: #selector(registAction), for: .touchUpInside)
        self.view.addSubview(confirmButton)

        confirmButton.snp.makeConstraints { (make) in
            make.width.equalTo(WidthRate(actureValue: 300))
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(lineFour.snp.bottom).offset(HeightRate(actureValue: 50))
            make.height.equalTo(HeightRate(actureValue: 45))
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
    @objc func getCode(){
        self.view.endEditing(true)
        if (self.phoneNumber.text?.count)! <= 0 || self.phoneNumber.text == nil {
            self.view.makeToast("请输入手机号", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        if !Tools.isMobileNumber(mobilenumber: self.phoneNumber.text!) {
            self.view.makeToast("输入手机号格式不正确", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        self.isCounting = true
        let parameters: NSDictionary  = ["MobileNumber":self.phoneNumber.text!,"VerificationType":1]
        viewModel.getVerifyCode(self, parameters: parameters)
    }
    @objc func registAction(){
        
        self.view.endEditing(true)
        if (self.phoneNumber.text?.count)! <= 0 || self.phoneNumber.text == nil {
            self.view.makeToast("请输入手机号", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        if !Tools.isMobileNumber(mobilenumber: self.phoneNumber.text!) {
            self.view.makeToast("输入手机号格式不正确", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        if (self.verifyCode.text?.count)! <= 0 || self.verifyCode.text == nil {
            self.view.makeToast("请输入验证码", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        if (self.password.text?.count)! <= 0 || self.password.text == nil {
            self.view.makeToast("请输入密码", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        let viewModel = RegisterViewModel()
        let parameters: NSDictionary  = ["MobileNumber":self.phoneNumber.text!,"VerificationCode":self.verifyCode.text!,"Password":self.password.text!,"client_id":EmakeStore]
        viewModel.regist(self, parameters: parameters, succussBlock: { _ in
            let vc = STRegistAuditViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    @objc func updateTimer() {
        if count<=0 {
            self.isCounting = false
            getVerifyCodeBtn.setTitle("获取验证码", for: .normal)
            getVerifyCodeBtn.isEnabled = true
            self.count = 60
            return
        }
        count = count - 1;
        getVerifyCodeBtn.isEnabled = false
        getVerifyCodeBtn.setTitle("\(count)s", for: .normal)
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
