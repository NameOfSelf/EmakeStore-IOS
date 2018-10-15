//
//  ViewController.swift
//  IMUIChat
//
//  Created by oshumini on 2017/2/23.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import Photos
import ObjectMapper
import TZImagePickerController
import Toast
import RealmSwift
import SKFPicPreview
class MyImageView: UIImageView {
  
}
enum MessageBodyType:String {
    case Text = "Text"
    case Image = "Image"
    case MutilePart = "MutilePart"
    case Goods = "Goods"
    case Voice = "Voice"
    case File = "File"
    case Video = "Video"
    case Order = "Order"
}
class STChatViewController: BaseViewController {

    @IBOutlet weak var messageCollectionView: IMUIMessageCollectionView!
    @IBOutlet weak var myInputView: IMUINewInputView!

    var isChatWithOffcial : Bool = false
    //用户信息
    var userId : String?
    var userName : String?
    var userPhone : String?
    var userAvatar : String?
    var userType : String?
    
    var lookUpImageArray : [UIImage]? = []
    var messageModel : MessageModel?
    var MaxMessageID : NSInteger? = 0
    var currentType:IMUIFeatureType = .voice
    var imageViewArr = [MyImageView]()
    let imageManage: PHCachingImageManager = PHCachingImageManager()
    var inputViewBottomItemArr = [IMUIFeatureIconModel]()
    var inputViewRightItemArr = [IMUIFeatureIconModel]()
    var inputViewLeftItemArr = [IMUIFeatureIconModel]()
    let imagePickerVC = UIImagePickerController()
    let viewModel = STOrderListViewModel()
    var page : NSInteger? = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sendMessageListCMD(with: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IMUIAudioPlayerHelper.sharedInstance.stopAudio()
        let clientId = "user/" + self.userId!
        let list = RealmChatTool.getAllChatListData()
        for data in list {
            if data.clientId == clientId {
                RealmChatTool.updateChatListCount(with: clientId)
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isChatWithOffcial {
            self.title = "平台客服"
        }else{
            self.title = self.userName ?? ""
        }
        self.baseSetNavLeftButtonIsBack()
        self.myInputView.inputViewDelegate = self
        self.messageCollectionView.delegate = self
        self.myInputView.moreViewHeight.constant = 0
        self.myInputView.isOffcial = self.isChatWithOffcial
        self.messageCollectionView.backgroundColor = .white
        self.messageCollectionView.messageCollectionView.register(MessageEventCollectionViewCell.self, forCellWithReuseIdentifier: MessageEventCollectionViewCell.self.description())
        self.messageCollectionView.messageCollectionView.register(MessageEventTipsCollectionViewCell.self, forCellWithReuseIdentifier: MessageEventTipsCollectionViewCell.self.description())
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(tapScreenKeyBoardDown))
        self.messageCollectionView.addGestureRecognizer(gesture)
        MQTTClientDefault.shared().delegate = self
        self.messageCollectionView.messageCollectionView.headerRefresh {
            self.myInputView.hideFeatureView()
            self.getChatDataList()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.messageCollectionView.messageCollectionView.mj_header.beginRefreshing()
        }
    }
    
    func getChatDataList() {
        
        self.page = self.page! + 1
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + self.userId!
        let isHaveAll = RealmChatTool.isMessageHaveAll(page: self.page!, lastMessageId: self.MaxMessageID!, chatRoomId: topic)
        if isHaveAll {//从数据库中取
            self.displayHistoryMessageFromRealm()
        }else{//调用CMD
            
            let lastMessageID = self.MaxMessageID! - (self.page!-1)*10
            self.sendMessageListCMD(with: lastMessageID)
            self.messageCollectionView.messageCollectionView.mj_header.endRefreshing()
        }
    }
    
    func displayHistoryMessageFromRealm() {
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + self.userId!
        RealmChatTool.getMessageDataWithPage(page: self.page!, lastMessageId: self.MaxMessageID!, chatRoomId: topic, successBlock: { (reuslt) in
            let resultData = reuslt as! [RealmChatData]
            for data in resultData{
                let message = MessageModel()
                message.From = MessageFromModel()
                message.From?.Avatar = data.userAvata
                message.From?.UserType = data.userType
                message.From?.PhoneNumber = data.userPhone
                message.From?.ClientID = data.clientId
                message.From?.DisplayName = data.userName
                message.From?.Group = data.groupInfo
                let model = Mapper<MessageBodyModel>().map(JSONString: data.message!)
                message.MessageBody = model
                message.MessageID = Int(data.messageID!)
                message.MessageId = data.messageIdString
                message.MessageType = data.messageType
                message.Timestamp = Int(data.sendTime!)
                self.messageReceived(messageModel: message, topic: topic)
            }
            self.messageCollectionView.messageCollectionView.mj_header.endRefreshing()
//            self.messageCollectionView.scrollToBottom(with: true)
        }) { (error) in
            self.page = self.page! - 1
            self.messageCollectionView.messageCollectionView.mj_header.endRefreshing()
        }
    }
  
    @objc func tapScreenKeyBoardDown() {
        self.myInputView.hideFeatureView()
    }
    
    //创建消息体
    func creatMessageModel(messageBody:[String:Any],messageId:String) -> [String:Any]{
        let UserDefalultStoreName = UserDefaults.standard.object(forKey: EmakeStoreName)
        let UserDefalultStorePhoto = UserDefaults.standard.object(forKey: EmakeStorePhoto)
        let grop = ["GroupName":UserDefalultStoreName ?? "","GroupPhoto":UserDefalultStorePhoto ?? ""]
        let gropModel = Mapper<GroupModel>().map(JSON: grop)
        let gropString = gropModel?.toJSONString(prettyPrint: true)
        let userId = UserDefaults.standard.object(forKey: EmakeUserId) ?? ""
        let nickName = UserDefaults.standard.object(forKey: EmakeUserNickName) ?? ""
        let phoneNumber = UserDefaults.standard.object(forKey: EmakeUserPhoneNumber) ?? ""
        let from : [String:Any] =  ["UserId":userId ,"ClientID":MQTTClienID,"PhoneNumber":phoneNumber,"DisplayName":nickName,"Group":gropString ?? "","Avatar":""]
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let toId = "chatroom/" + storeId + "/" + self.userId!
        let message : [String : Any] = ["ToId":toId,"From":from,"MessageBody":messageBody,"MessageId":messageId,"MessageType":"Message"]
        return message
    }
    
    //发送消息
    func sendMessage(message:[String:Any]) {
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + self.userId!
        MQTTClientDefault.shared().sendMessage(withMessage: message, topic: topic) { (error) in
            if UserDefaults.standard.object(forKey: EmakeServerList) == nil {
                if self.isChatWithOffcial {
                    self.sendTips(tips: "客服接入中")
                    self.sendRequestServiceCMD()
                }
            }else{
                let serverList = UserDefaults.standard.object(forKey: EmakeServerList) as! [String]
                if serverList.count <= 0 {
                    if self.isChatWithOffcial {
                        self.sendTips(tips: "客服接入中")
                        self.sendRequestServiceCMD()
                    }
                }
            }
        }
    }
    //获取个人信息
    func getMyUserInfo() -> MyUser {
        let user = MyUser()
        if UserDefaults.standard.object(forKey: EmakeUserNickName) != nil {
            user.userName = UserDefaults.standard.object(forKey: EmakeUserNickName) as? String
        }else{
            user.userName = ""
        }
        user.isOutGoing = true
        if UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) != nil {
            user.userAvata = UserDefaults.standard.object(forKey: EmakeHeadImageUrlString) as? String
        }else{
            user.userAvata = ""
        }
        user.userClientId = MQTTClienID
        return user
    }
    
    func pushTZImagePickerController() {
        
        let imagePickerVC = TZImagePickerController(maxImagesCount: 1, columnNumber: 4, delegate: self , pushPhotoPickerVc: true)
        imagePickerVC?.allowTakePicture = false
        imagePickerVC?.allowPickingImage = true
        imagePickerVC?.allowPickingOriginalPhoto = true
        imagePickerVC?.allowPickingGif = true
        imagePickerVC?.allowPickingMultipleVideo = true
        imagePickerVC?.sortAscendingByModificationDate = true
        imagePickerVC?.showSelectBtn = true
        imagePickerVC?.allowCrop = false
        imagePickerVC?.didFinishPickingPhotosHandle = { (photos, assets, isSelectOriginalPhoto) in
            if (photos?.count)! <= 0 {
                return
            }else {
                let imageData = UIImagePNGRepresentation(photos![0])
                self.didShootPicture(picture: imageData!)
            }
        }
        self.present(imagePickerVC!, animated: true, completion: nil)
    }
    
    func pushImagePickerController() {
        
        self.imagePickerVC.delegate = self
        let sourceType = UIImagePickerControllerSourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            self.imagePickerVC.sourceType = sourceType
            if #available(iOS 8.0, *) {
                self.imagePickerVC.modalPresentationStyle = .overCurrentContext
            }
            self.present(self.imagePickerVC, animated: true, completion: nil)
        }else{
            self.view.makeToast("模拟器无法打开照相机", duration: 1.0, position: CSToastPositionCenter)
        }
        
    }
    
    func getTakePhotoPermission() -> Bool {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if (authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied){
            if #available(iOS 8.0, *) {
                let alert = UIAlertController.init(title: "无法使用相机", message: "请在iPhone的设置-隐私-相机", preferredStyle: .alert)
                let cancle = UIAlertAction.init(title: "无法使用相机", style: .cancel) { (action) in
                    
                }
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            }
            return false
        }else if (authStatus == AVAuthorizationStatus.notDetermined){
            if #available(iOS 7.0, *) {
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    if granted {
                        DispatchQueue.main.async {
                            let _ =  self.getTakePhotoPermission()
                        }
                    }
                    
                }
            }else{
                let _ =  self.getTakePhotoPermission()
            }
            return false
        }else if (TZImageManager.authorizationStatus() == 2){
            let alert = UIAlertController.init(title: "无法使用相机", message: "请在iPhone的设置-隐私-相机", preferredStyle: .alert)
            let cancle = UIAlertAction.init(title: "无法使用相机", style: .cancel) { (action) in
                
            }
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
            return false
        }else if (TZImageManager.authorizationStatus() == 0){
            TZImageManager().requestAuthorization {
                let _ =  self.getTakePhotoPermission()
            }
            return false
        }else{
            return true
        }
    }
    
    func sendMessageListCMD(with mesageId:NSInteger) {
        
        let messageListCMD = CommandModel.creatCustomerLisCMD(userId: self.userId!, mesageId: mesageId)
        MQTTClientDefault.shared().sendMessage(withMessage: messageListCMD, topic: MQTT_CMDTopic) { (error) in
        
        }
    }
    
    func sendStoreCustomerListCMD() {
        let messageListCMD = CommandModel.creatStoreCustomerLisCMD()
        MQTTClientDefault.shared().sendMessage(withMessage: messageListCMD, topic: MQTT_CMDTopic) { (error) in
        }
    }
    
    func sendRequestSwitchServiceCMD(serverId:String)  {
        
        let userinfo = MessageFromModel()
        userinfo.UserId = self.userId
        userinfo.Avatar = self.userAvatar
        userinfo.DisplayName = self.userName
        userinfo.PhoneNumber = self.userPhone
        userinfo.Avatar = self.userAvatar
        userinfo.ClientID = "user/" + self.userId!
        userinfo.UserType = self.userType
        userinfo.Group = ""
        var userinfoArray : [[String:Any]] = []
        userinfoArray.append(userinfo.toJSON())
        let data = try? JSONSerialization.data(withJSONObject: userinfoArray, options: .prettyPrinted)
        let jsonStr = String(data: data!, encoding: String.Encoding.utf8)
        let messageListCMD = CommandModel.creatRequestSwitchServiceCMD(userId: self.userId!, switchServerId: serverId, userInfo: jsonStr ?? "")
        MQTTClientDefault.shared().sendMessage(withMessage: messageListCMD, topic: MQTT_CMDTopic) { (error) in
            if (error as! String) == "success" {
                let alert = UIAlertController.init(title: "提示", message: "转接成功", preferredStyle: .alert)
                let cancle = UIAlertAction.init(title: "确定", style: .cancel) { (action) in
                    
                }
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func sendRequestServiceCMD() {
        let requestServerCMD = CommandModel.creatRequestServiceCMD()
        MQTTClientDefault.shared().sendMessage(withMessage: requestServerCMD, topic: MQTT_CMDTopic) { (error) in
        }
    }
    
    func sendTips(tips:String) {
        
        let MessageId = UUID.init().uuidString
        let tipEvent = MessageEventTipsModel.init(msgId: MessageId, messageId: 10000, eventText: tips, sendTime:"")
        if self.messageCollectionView.chatDataManager.allMsgidArr.contains(MessageId){
            self.messageCollectionView.updateMessage(with: tipEvent)
        }else{
            self.messageCollectionView.addMessageOrder(with: tipEvent)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}

// MARK: - IMUIInputViewDelegate
extension STChatViewController: IMUINewInputViewDelegate  {
    
    //发送文字
    func sendTextMessage(_ messageText: String) {
        
        let messageBody : [String:Any] = ["Type":MessageBodyType.Text.rawValue,"Text":messageText]
        let MessageId = UUID.init().uuidString
        let messageModel = self.creatMessageModel(messageBody: messageBody,messageId:MessageId)
        self.sendMessage(message: messageModel)
        let user = self.getMyUserInfo()
        let outGoingmessage = MyMessageModel(text: messageText, isOutGoing: true, isNeedShowTime: false, msgId: MessageId, messageID: 0,user:user,messageStatus:.sending)
        self.messageCollectionView.appendMessage(with: outGoingmessage)
    }
    //快捷回复
    func didSelectConnvientReply() {
        let vc = STMessageConnvientReplyViewController()
        vc.block = { [weak self] text in
            self?.sendTextMessage(text!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //订单
    func didSelectOrder() {
        
        let vc = STUserOrderViewController()
        vc.userId = self.userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //产品
    func didSelectProduct() {
        let vc = STProductRecommendViewController()
        vc.block = { [weak self] model in
            let jsonString = model?.toJSONString(prettyPrint: true)
            let messageBody : [String:Any] = ["Type":MessageBodyType.Goods.rawValue,"Text":jsonString ?? ""]
            let MessageId = UUID.init().uuidString
            let messageModel = self?.creatMessageModel(messageBody: messageBody,messageId:MessageId)
            self?.sendMessage(message: messageModel!)
            let user = self?.getMyUserInfo()
            let outGoingmessage = MyMessageModel(productJsonString: jsonString!, isOutGoing: true, isNeedShowTime: false, msgId: MessageId,messageID: 0,user:user!,messageStatus:.sending)
            self?.messageCollectionView.appendMessage(with: outGoingmessage)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //客服转接
    func didSelectSwitchServers() {
        
        self.sendStoreCustomerListCMD()
    }
    //结束对话
    func didSelectEndServers() {
        let alert = STAlertView.init(frame: CGRect(x: 0, y: 0, width: WidthRate(actureValue: 280), height: HeightRate(actureValue: 160)), title: "结束对话", message: "确定要结束对话吗？", leftTitle: "取消", rightTitle: "确定")
        alert?.delegate = self;
        alert?.showAnimated()
    }
    //选择相册
    func didSeletedGallery() {
        
        self.pushTZImagePickerController()
    }
   //选择拍照
    func didSelectShootPicture() {
        
        if self.getTakePhotoPermission() {
            self.pushImagePickerController()
        }
    }
    
    func switchToMicrophoneMode(recordVoiceBtn: UIButton) {
        
    }
  
    func switchToCameraMode(cameraBtn: UIButton) {
        
    }
  
    func switchToEmojiMode(cameraBtn: UIButton) {
        
    }
  
    func didShootPicture(picture: Data) {
        
        let MessageId = UUID.init().uuidString
        let imagePath = self.getLocalPath(UUID: MessageId, type: .Image)
        let imageOSSPath = self.getOSSPath(UUID: MessageId, type: .Image)
        let fileName = MessageId + ".png"
        let messageBody : [String:Any] = ["Type":MessageBodyType.Image.rawValue,"Image":imageOSSPath]
        let user = self.getMyUserInfo()
        OSSClientDefault.getSharedInstance().uploadObjectAsync(uploadData: picture, fileName: fileName, type: OSSUploadType.image, successBlock: {
            DispatchQueue.main.async {
                do {
                    try picture.write(to: URL(fileURLWithPath: imagePath))
                    DispatchQueue.main.async {
                        let outGoingmessage = MyMessageModel(imagePath: imagePath, isOutGoing: true, isNeedShowTime: false, msgId: MessageId,messageID: 0, user: user, messageStatus: .sending)
                        self.messageCollectionView.appendMessage(with: outGoingmessage)
                        let messageModel = self.creatMessageModel(messageBody: messageBody,messageId:MessageId)
                        self.sendMessage(message: messageModel)
                    }
                } catch {
                    print("write image file error")
                }
            }
        }, failureblock: {
            let outGoingmessage = MyMessageModel(imagePath: imagePath, isOutGoing: true, isNeedShowTime: false, msgId: MessageId,messageID: 0, user: user, messageStatus: .failed)
            self.messageCollectionView.appendMessage(with: outGoingmessage)
            
        })
        
    }
  
    func startRecordVoice() {
        
        self.perform(#selector(stopRecord), with: nil, afterDelay: 60)
    }
  
    @objc func stopRecord() {
        
        let cell = self.myInputView.functionView.featureCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! IMUIRecordVoiceCell
        cell.finishRecordVoice()
    }
    
    
    func startRecordVideo() {
        
        
    }
  
    func finishRecordVideo(videoPath: String, durationTime: Double) {
    
    }
    //录音完成
    func finishRecordVoice(_ voicePath: String, durationTime: Double) {
        
        if durationTime < 1.0 {
            self.view.makeToast("录音时间太短", duration: 1.0, position: CSToastPositionCenter)
            return;
        }
        let MessageId = UUID.init().uuidString
        let voiceLocalPath = self.getLocalPath(UUID: MessageId, type: .Voice)
        let voiceOSSPath = self.getOSSPath(UUID: MessageId, type: .Voice)
        let fileName = MessageId + ".m4a"
        var voiceData : Data?
        let duration = String(format: "%d", arguments: [Int(durationTime)])
        do {
            let url = URL(fileURLWithPath: voicePath)
            voiceData = try Data.init(contentsOf: url)
        }catch {
            print("write image file error")
            return
            
        }
        let messageBody : [String:Any] = ["Type":MessageBodyType.Voice.rawValue,"Voice":voiceOSSPath,"VoiceDuration":duration]
        let user = self.getMyUserInfo()
        OSSClientDefault.getSharedInstance().uploadObjectAsync(uploadData: voiceData!, fileName: fileName, type: OSSUploadType.voice, successBlock: {
            DispatchQueue.main.async {
                do {
                    print(voiceOSSPath)
                    try voiceData?.write(to: URL(fileURLWithPath: voiceLocalPath))
                    DispatchQueue.main.async {
                        let message = MyMessageModel(voicePath: voiceLocalPath, duration: CGFloat(durationTime), isOutGoing: true, isNeedShowTime: false, msgId: MessageId,messageID: 0, user: user, messageStatus: .sending)
                        self.messageCollectionView.appendMessage(with: message)
                        let messageModel = self.creatMessageModel(messageBody: messageBody,messageId:MessageId)
                        self.sendMessage(message: messageModel)
                    }
                } catch {
                    print("write image file error")
                }
            }
        }) {
            let message = MyMessageModel(voicePath: voiceLocalPath, duration: CGFloat(durationTime), isOutGoing: true, isNeedShowTime: false, msgId: MessageId,messageID: 0, user: user, messageStatus: .failed)
            self.messageCollectionView.appendMessage(with: message)
        }
        
    }
  
    func getOSSPath(UUID:String,type:MessageBodyType) -> String {
        
        var OSSPath:String? = nil
        if type == .Image {
            OSSPath = String(format: "%@%@.png", arguments: [ALiYunOSSImagePath,UUID])
        }else if type == .Voice {
            OSSPath = String(format: "%@%@.m4a", arguments: [ALiYunOSSVoicePath,UUID])
        }else if type == .File {
            
        }
        return OSSPath ?? ""
    }
    
    func getLocalPath(UUID:String,type:MessageBodyType) -> String {
        
        var localPath:String? = nil
        if type == .Image {
            localPath = String(format: "%@/Documents/%@.png", arguments: [NSHomeDirectory(),UUID])
        }else if type == .Voice {
            localPath = String(format: "%@/Documents/%@.m4a", arguments: [NSHomeDirectory(),UUID])
        }else if type == .File {
            
        }
        return localPath ?? ""
    }
    
    func showOptionView() {
        
    }
}


// MARK - IMUIMessageMessageCollectionViewDelegate
extension STChatViewController: IMUIMessageMessageCollectionViewDelegate {
    
  func messageCollectionView(messageCollectionView: UICollectionView, forItemAt: IndexPath, messageModel: IMUIMessageProtocol) -> UICollectionViewCell? {
        if messageModel is MessageEventModel {
            let cellIdentify = MessageEventCollectionViewCell.self.description()
            let cell = messageCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify, for: forItemAt) as! MessageEventCollectionViewCell
            let message = messageModel as! MessageEventModel
            cell.delegate = self
            cell.presentCell(eventText: message.eventText)
            return cell
        }else if messageModel is MessageEventTipsModel{
            let cellIdentify = MessageEventTipsCollectionViewCell.self.description()
            let cell = messageCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentify, for: forItemAt) as! MessageEventTipsCollectionViewCell
            let message = messageModel as! MessageEventTipsModel
            cell.presentCell(tips: message.eventText)
            return cell
        }else {
            return nil
        }
    }
  
    func messageCollectionView(messageCollectionView: UICollectionView, heightForItemAtIndexPath forItemAt: IndexPath, messageModel: IMUIMessageProtocol) -> NSNumber? {
        if messageModel is MessageEventModel {
            let number = NSNumber.init(value: Double(HeightRate(actureValue: 240)))
            return number
        } else if messageModel is MessageEventTipsModel {
            let number = NSNumber.init(value: Double(HeightRate(actureValue: 40)))
            return number
        }else{
            return nil
        }
    }
  
    func messageCollectionView(didTapMessageBubbleInCell: UICollectionViewCell, model: IMUIMessageProtocol) {
        let message = model as! MyMessageModel
        if message.type == MessageBodyType.Image.rawValue {
            let localPath = self.getLocalPath(UUID: model.msgId, type: .Image)
            do {
                let imageData = try Data(contentsOf: URL(fileURLWithPath: localPath))
                let image = UIImage(data: imageData)
                self.lookUpImageArray?.append(image!)
                let vc = SKFPreViewNavController(selectedPhotos: NSMutableArray(array: self.lookUpImageArray!),index: 0, deletePic: false)
                self.present(vc!, animated: true, completion: nil)
            }catch{
                
            }
        }else if message.type == MessageBodyType.MutilePart.rawValue {
            let data = message.text().data(using: .utf8)
            do {
                let jsonObj:[String:Any] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                let messageBody = Mapper<MessageBodyModel>().map(JSON: jsonObj)
                let vc = STReuseableWebViewController()
                vc.webViewType = .contractPreview
                vc.rightButtonTitle = "发送"
                vc.messageBody = messageBody
                vc.url = (messageBody?.Url)!
                vc.sendBlock = { [weak self] model in
                    self?.sendProtocol(with : model!)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }catch {
                
            }
            
        }
    }
  
    func messageCollectionView(didTapHeaderImageInCell: UICollectionViewCell, model: IMUIMessageProtocol) {
        
    }
  
    func messageCollectionView(didTapStatusViewInCell: UICollectionViewCell, model: IMUIMessageProtocol) {
        
    }

  
    func messageCollectionView(_: UICollectionView, willDisplayMessageCell: UICollectionViewCell, forItemAt: IndexPath, model: IMUIMessageProtocol) {
        
    }
  
    func messageCollectionView(_: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath, model: IMUIMessageProtocol) {
  
    }
  
    func messageCollectionView(_ willBeginDragging: UICollectionView) {
        DispatchQueue.main.async {
            self.myInputView.hideFeatureView()
        }
    }
  
    func showToast(alert: String) {
        
        let toast = UIAlertView(title: alert, message: nil, delegate: nil, cancelButtonTitle: nil)
        toast.show()
        toast.dismiss(withClickedButtonIndex: 0, animated: true)
    }
}
extension STChatViewController : MessageEventCellDelegate {
    
    func didTapMessageBubbleWithModel(eventText: String) {
        
        let vc = STMessaegOrderDetailViewController()
        let model = Mapper<MessageOrderModel>().map(JSONString: eventText)
        vc.orderNo = model?.ContractNo
        vc.sendBlock = { [weak self] model in
            self?.sendProtocol(with : model!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendProtocol(with model:MessageBodyModel) {
        
        let MessageId = UUID.init().uuidString
        let messageBody = model.toJSON()
        let messageModel = self.creatMessageModel(messageBody: messageBody,messageId:MessageId)
        self.sendMessage(message: messageModel)
        let user = self.getMyUserInfo()
        let outGoingmessage = MyMessageModel(contractJsonString: model.toJSONString()!, isOutGoing: true, isNeedShowTime: false, msgId: MessageId, messageID: 0, user: user, messageStatus: .sending)
        self.messageCollectionView.appendMessage(with: outGoingmessage)
    }
    
}
extension STChatViewController : MQTTClientDefaultDelegate {
    //消息
    func messageReceived(messageModel: MessageModel, topic: String) {
        //消息展示刷新
        self.updateMessageList(messageModel: messageModel, topic: topic)
        var user = MyUser()
        if messageModel.From?.ClientID == MQTTClienID {
            user = getMyUserInfo()
        }else{
            user.userName = messageModel.From?.DisplayName ?? ""
            if messageModel.From?.Avatar == nil {
                user.userAvata = ""
            }else{
                user.userAvata = messageModel.From?.Avatar
            }
            user.isOutGoing = false
            user.userClientId = messageModel.From?.ClientID
        }
        switch messageModel.MessageBody?.Type{
        case MessageBodyType.Text.rawValue:
            let message = MyMessageModel(text: (messageModel.MessageBody?.Text)!, isOutGoing: user.isOutGoing!, isNeedShowTime: false, msgId: messageModel.MessageId!,messageID: messageModel.MessageID!,user:user,messageStatus:.success)
            if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                self.messageCollectionView.updateMessage(with: message)
            }else{
                self.messageCollectionView.addMessageOrder(with: message)
            }
        case MessageBodyType.Image.rawValue:
            let localPath = self.getLocalPath(UUID: messageModel.MessageId!, type: .Image)
            let message = MyMessageModel(imagePath: localPath, isOutGoing: user.isOutGoing!, isNeedShowTime: false, msgId: messageModel.MessageId!,messageID: messageModel.MessageID!,user: user, messageStatus: .success)
            DispatchQueue.main.async {
                do {
                    if !FileManager().fileExists(atPath: localPath){
                        let data = NSData(contentsOf: URL(string: (messageModel.MessageBody?.Image)!)!)
                        
                        try data?.write(to: URL(fileURLWithPath: localPath))
                        DispatchQueue.main.async {
                            if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                                self.messageCollectionView.updateMessage(with: message)
                            }else{
                                self.messageCollectionView.addMessageOrder(with: message)
                            }
                        }
                    }else{
                        if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                            self.messageCollectionView.updateMessage(with: message)
                        }else{
                            self.messageCollectionView.addMessageOrder(with: message)
                        }
                    }
                } catch {
                    print("write image file error")
                }
            }
        case MessageBodyType.Voice.rawValue:
            let localPath = self.getLocalPath(UUID: messageModel.MessageId!, type: .Voice)
            var duration = 0.0
            if messageModel.MessageBody?.VoiceDuration != nil { 
                duration = Double((messageModel.MessageBody?.VoiceDuration)!)
            }
            let message = MyMessageModel(voicePath: localPath, duration: CGFloat(duration), isOutGoing: user.isOutGoing!, isNeedShowTime: false, msgId: messageModel.MessageId!,messageID: messageModel.MessageID!, user: user, messageStatus: .success)
            DispatchQueue.main.async {
                do {
                    if !FileManager().fileExists(atPath: localPath){
                        let data = NSData(contentsOf: URL(string: (messageModel.MessageBody?.Voice)!)!)
                        try data?.write(to: URL(fileURLWithPath: localPath))
                        DispatchQueue.main.async {
                            if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                                self.messageCollectionView.updateMessage(with: message)
                            }else{
                                self.messageCollectionView.addMessageOrder(with: message)
                            }
                        }
                    }else{
                        if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                            self.messageCollectionView.updateMessage(with: message)
                        }else{
                            self.messageCollectionView.addMessageOrder(with: message)
                        }
                    }
                } catch {
                    print("write image file error")
                }
            }
        case MessageBodyType.Goods.rawValue:
            let message = MyMessageModel(productJsonString: (messageModel.MessageBody?.Text)!, isOutGoing: user.isOutGoing!, isNeedShowTime: false, msgId: messageModel.MessageId!,messageID: messageModel.MessageID!,user:user,messageStatus:.success)
            if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                self.messageCollectionView.updateMessage(with: message)
            }else{
                self.messageCollectionView.addMessageOrder(with: message)
            }
        case MessageBodyType.Order.rawValue:
            let message = MessageEventModel.init(msgId: messageModel.MessageId!,messageId:messageModel.MessageID!, eventText: (messageModel.MessageBody?.Text)!, sendTime: "2018-4-6")
            if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                self.messageCollectionView.updateMessage(with: message)
            }else{
                self.messageCollectionView.addMessageOrder(with: message)
            }
        case MessageBodyType.MutilePart.rawValue:
            let message = MyMessageModel(contractJsonString: (messageModel.MessageBody?.toJSONString())!, isOutGoing: user.isOutGoing!, isNeedShowTime: false, msgId: messageModel.MessageId!, messageID: messageModel.MessageID!, user: user, messageStatus: .success)
            if self.messageCollectionView.chatDataManager.allMsgidArr.contains(messageModel.MessageId!){
                self.messageCollectionView.updateMessage(with: message)
            }else{
                self.messageCollectionView.addMessageOrder(with: message)
            }
        default:
            break
        }
    }
    //指令
    func commandReceived(commandModel: CommandModel, topic: String) {
        //
        if commandModel.cmd == CommandType.UserMessageList.rawValue {
            self.MaxMessageID = commandModel.message_id_last
            self.page = 0
            self.messageCollectionView.messageCollectionView.mj_header.beginRefreshing()
        }else if commandModel.cmd == CommandType.StoreCustomerList.rawValue {
            let vc = STSwitchListViewController()
            vc.switchList = commandModel.customer_ids
            vc.block = { [weak self] text in
                let part = text.components(separatedBy: "/")
                self?.sendRequestSwitchServiceCMD(serverId: part[2])
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else if commandModel.cmd == CommandType.CustomerAcceptService.rawValue {
            let part = commandModel.customer_id?.components(separatedBy: "/")
            if part?.count == 2 {
                let tips = String(format: "客服：%@为你服务", arguments: [part?[1] ?? ""])
                self.sendTips(tips: tips)
            }
            if UserDefaults.standard.object(forKey: EmakeServerList) == nil {
                var list: [String] = []
                list.append(commandModel.customer_id!)
                UserDefaults.standard.set(list, forKey: EmakeServerList)
            }else{
                var serverList = UserDefaults.standard.object(forKey: EmakeServerList) as! [String]
                if !serverList.contains(commandModel.customer_id!) {
                    serverList.append(commandModel.customer_id!)
                    UserDefaults.standard.set(serverList, forKey: EmakeServerList)
                }
            }
        }else if commandModel.cmd == CommandType.CustomerClosedService.rawValue {
            let part = commandModel.customer_id?.components(separatedBy: "/")
            if part?.count == 2 {
                let tips = String(format: "客服：%@已离开", arguments: [part?[1] ?? ""])
                self.sendTips(tips: tips)
            }
            if UserDefaults.standard.object(forKey: EmakeServerList) == nil {
                return
            }else{
                var serverList = UserDefaults.standard.object(forKey: EmakeServerList) as! [String]
                if serverList.contains(commandModel.customer_id!) {
                    let index = serverList.index(of: commandModel.customer_id!)
                    serverList.remove(at: index!)
                    UserDefaults.standard.set(serverList, forKey: EmakeServerList)
                }
            }
        }
    }
    
    func updateMessageList(messageModel: MessageModel, topic: String) {
        
        let chatList = RealmChatListData()
        chatList.chatRoomID = topic
        let part = topic.components(separatedBy: "/")
        var clientId = ""
        if part.count == 3 {
            clientId = "user/" + part[2]
        }
        let messageBodyText = messageModel.MessageBody?.toJSONString(prettyPrint: true)
        chatList.userName = self.userName ?? ""
        chatList.userAvata = self.userAvatar ?? ""
        chatList.userPhone = self.userPhone ?? ""
        chatList.userType = self.userType ?? ""
        chatList.clientId = clientId
        chatList.message =  messageBodyText ?? ""
        chatList.sendTime = String(format: "%d", arguments: [messageModel.Timestamp!])
        chatList.groupInfo = messageModel.From?.Group ?? ""
        chatList.messageType = messageModel.MessageBody?.Type
        if self.userId == part[2]{
            RealmChatTool.insertChatListData(by: chatList)
        }
    }
}
extension STChatViewController : TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let originalImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        UIImageWriteToSavedPhotosAlbum(originalImage, self, nil, nil)
        let scale = originalImage.size.width / originalImage.size.height
        var size = CGSize(width: 0, height: 0)
        if scale > 1.0 {
            if originalImage.size.width < ScreenWidth {
                //最长边小于屏幕宽度时，采用原图
                size = CGSize(width: originalImage.size.width, height: originalImage.size.height)
            }else {
                size = CGSize(width: ScreenWidth, height: ScreenWidth/scale)
            }
        }else{
            if originalImage.size.height < ScreenWidth {
                //最长边小于屏幕高度时，采用原图
                size = CGSize(width: originalImage.size.width, height: originalImage.size.height)
            }else {
                size = CGSize(width: ScreenWidth*scale, height: ScreenHeight)
            }
        }
        let image = UIImage.pressImageWithImage(image:originalImage,scaleSize:size)
        self.didShootPicture(picture: UIImagePNGRepresentation(image)!)
        picker.dismiss(animated: true, completion: nil)
    }
}
extension STChatViewController : UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.myInputView.hideFeatureView()
    }
}
extension STChatViewController : STAlertViewDelegate {
    
    func alertViewLeftButtonClick() {
        
    }
    
    func alertViewRightButtonClick() {
        
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let topic = "chatroom/" + storeId + "/" + (self.userId)!
        MQTTClientDefault.shared().unSubcribeTo(topic: topic)
        self.navigationController?.popViewController(animated: true)
    }
}
