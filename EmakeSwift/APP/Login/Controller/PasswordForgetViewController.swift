//
//  PasswordForgetViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/4/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import Toast
class PasswordForgetViewController: BaseViewController {
    
    var phoneNumber = UITextField()
    var verifyCode = UITextField()
    var password = UITextField()
    var passwordConfrim = UITextField()
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
    let viewModel = PasswordForgetViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "忘记密码"
        self.view.backgroundColor = .white
        self.baseSetNavLeftButtonIsBack()
        // Do any additional setup after loading the view.
    }
    override func configSubviews() {
        
        let phoneNumberImage = UIImageView(image:UIImage(named:"login_phone number"))
        phoneNumberImage.contentMode = .scaleAspectFit
        self.view.addSubview(phoneNumberImage)
        
        phoneNumberImage.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 34))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(HeightRate(actureValue: 65))
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
        password.placeholder = "重置密码"
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
        
        
        let passwordImageConfirm = UIImageView(image:UIImage(named:"login_password"))
        passwordImageConfirm.contentMode = .scaleAspectFit
        self.view.addSubview(passwordImageConfirm)
        
        passwordImageConfirm.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: WidthRate(actureValue: 34)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(HeightRate(actureValue: 25))
            make.top.equalTo(passwordImage.snp.bottom).offset(HeightRate(actureValue: 34))
        }
        
        
        passwordConfrim.clearButtonMode = .whileEditing
        passwordConfrim.placeholder = "请再次输入密码"
        passwordConfrim.font = AdaptFont(actureValue: 16)
        passwordConfrim.isSecureTextEntry = true
        self.view.addSubview(passwordConfrim)
        
        passwordConfrim.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordImageConfirm.snp.centerY)
            make.height.equalTo(HeightRate(actureValue: 40))
            make.left.equalTo(passwordImageConfirm.snp.right).offset(WidthRate(actureValue: 15))
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -75)))
        }
        
        
        let passwordConfirmSecurityBtn = UIButton(type: .custom)
        passwordConfirmSecurityBtn.setImage(UIImage(named:"login_eyes_closed"), for: .normal)
        passwordConfirmSecurityBtn.setImage(UIImage(named:"login_eyes_opend"), for: .selected)
        passwordConfirmSecurityBtn.addTarget(self, action: #selector(securityOption(_:)), for: .touchUpInside)
        self.view.addSubview(passwordConfirmSecurityBtn)
        
        passwordConfirmSecurityBtn.snp.makeConstraints { (make) in
            make.right.equalTo(WidthRate(actureValue: WidthRate(actureValue: -30)))
            make.width.equalTo(WidthRate(actureValue: 25))
            make.height.equalTo(WidthRate(actureValue: 25))
            make.centerY.equalTo(passwordImage.snp.centerY)
        }
        
        
        let lineLast = UILabel()
        lineLast.backgroundColor = BaseColor.SepratorLineColor
        self.view.addSubview(lineLast)
        
        lineLast.snp.makeConstraints { (make) in
            make.left.equalTo(WidthRate(actureValue: 34))
            make.right.equalTo(WidthRate(actureValue: -30))
            make.height.equalTo(1.5)
            make.top.equalTo(passwordImageConfirm.snp.bottom).offset(HeightRate(actureValue: 18))
        }
        
        let confirmButton = UIButton(type:.custom)
        confirmButton.setTitle("提 交", for: .normal)
        confirmButton.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = AdaptFont(actureValue: 16)
        confirmButton.layer.cornerRadius = WidthRate(actureValue: 6)
        confirmButton.addTarget(self, action: #selector(confirmSomething), for: .touchUpInside)
        self.view.addSubview(confirmButton)
        
        confirmButton.snp.makeConstraints { (make) in
            make.width.equalTo(WidthRate(actureValue: 300))
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(lineLast.snp.bottom).offset(HeightRate(actureValue: 50))
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
        self.isCounting = true
        if (self.phoneNumber.text?.count)! <= 0 || self.phoneNumber.text == nil {
            self.view.makeToast("请输入手机号", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        if !Tools.isMobileNumber(mobilenumber: self.phoneNumber.text!) {
            self.view.makeToast("输入手机号格式不正确", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        self.isCounting = true
        let parameters: NSDictionary  = ["MobileNumber":self.phoneNumber.text!,"VerificationType":2]
        viewModel.getVerifyCode(self, parameters: parameters)
    }
    @objc func confirmSomething(){
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
        if (self.passwordConfrim.text?.count)! <= 0 || self.passwordConfrim.text == nil {
            self.view.makeToast("请输入密码", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        if self.passwordConfrim.text != self.password.text {
            self.view.makeToast("两次输入的密码不一致", duration: 1.0, position: CSToastPositionCenter)
            return
        }
        let passwordString  = self.password.text! + ":emake"
        let passwordMD5String = Tools.md5String(str: passwordString)
        //大小写转换
        
        let parameters: NSDictionary  = ["MobileNumber":self.phoneNumber.text!,"VerificationCode":self.verifyCode.text!,"Password":passwordMD5String,"client_id":EmakeStore]
        viewModel.passwordForget(self, parameters: parameters) { (tips) in
            self.view.makeToast("重置成功", duration: 1.5, position: CSToastPositionCenter, title: nil, image: nil, style: nil, completion: { (_) in
                self.navigationController?.popViewController(animated: true)
            })
            self.navigationController?.popViewController(animated: true)
        }
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
