//
//  MyMessageModel.swift
//  IMUIChat
//
//  Created by oshumini on 2017/3/5.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit

class MyMessageModel: IMUIMessageModel {
  
  open var myTextMessage: String = ""
  
  var mediaPath: String = ""
  override func mediaFilePath() -> String {
    return mediaPath
  }
  
  override var resizableBubbleImage: UIImage {
    // return defoult message bubble
    return super.resizableBubbleImage
  }
  
  init(msgId: String, messageIDInt:Int, messageStatus: IMUIMessageStatus, fromUser: MyUser, isOutGoing: Bool, date: Date, type: String, text: String, mediaPath: String, layout: IMUIMessageCellLayoutProtocol, duration: CGFloat?) {
    
    self.myTextMessage = text
    self.mediaPath = mediaPath
    let chatTime = MyMessageModel.formatChatDate(date: date)
    super.init(msgId: msgId, messageID: messageIDInt, messageStatus: messageStatus, fromUser: fromUser, isOutGoing: isOutGoing, time: chatTime, type: type, cellLayout: layout, duration: duration)
  }
    
    convenience init(productJsonString: String, isOutGoing: Bool, isNeedShowTime: Bool, msgId: String, messageID:Int, user: MyUser, messageStatus: IMUIMessageStatus) {
        
        let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                           isNeedShowTime: isNeedShowTime,
                                           bubbleContentSize: CGSize(width: WidthRate(actureValue: 250), height: HeightRate(actureValue: 74)),
                                           bubbleContentInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15),
                                           timeLabelContentSize: CGSize(width: 200, height: 20),
                                           type: "Good")
        self.init(msgId: msgId,messageIDInt: messageID, messageStatus: messageStatus, fromUser: user, isOutGoing: isOutGoing, date: Date(), type: "Good", text: productJsonString, mediaPath: "", layout:  myLayout, duration: nil)
    }
    
    convenience init(fileJsonString: String, isOutGoing: Bool, isNeedShowTime: Bool, msgId: String, messageID:Int, user: MyUser, messageStatus: IMUIMessageStatus) {
        
        let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                           isNeedShowTime: isNeedShowTime,
                                           bubbleContentSize: CGSize(width: 233, height: 74),
                                           bubbleContentInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15),
                                           timeLabelContentSize: CGSize(width: 200, height: 20),
                                           type: "File")
        self.init(msgId: msgId,messageIDInt: messageID, messageStatus: messageStatus, fromUser: user, isOutGoing: isOutGoing, date: Date(), type: "File", text: fileJsonString, mediaPath: "", layout:  myLayout, duration: nil)
    }
    
    convenience init(contractJsonString: String, isOutGoing: Bool, isNeedShowTime: Bool, msgId: String, messageID:Int, user: MyUser, messageStatus: IMUIMessageStatus) {
        
        let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                           isNeedShowTime: isNeedShowTime,
                                           bubbleContentSize: CGSize(width: WidthRate(actureValue: 255), height: HeightRate(actureValue: 170)),
                                           bubbleContentInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15),
                                           timeLabelContentSize: CGSize(width: 200, height: 20),
                                           type: "MutilePart")
        self.init(msgId: msgId,messageIDInt: messageID, messageStatus: messageStatus, fromUser: user, isOutGoing: isOutGoing, date: Date(), type: "MutilePart", text: contractJsonString, mediaPath: "", layout:  myLayout, duration: nil)
    }
  
  convenience init(text: String, isOutGoing: Bool, isNeedShowTime: Bool, msgId: String, messageID:Int, user: MyUser, messageStatus: IMUIMessageStatus) {

    let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                          isNeedShowTime: isNeedShowTime,
                                       bubbleContentSize: MyMessageModel.calculateTextContentSize(text: text),
                                     bubbleContentInsets: UIEdgeInsets.zero,
                                    timeLabelContentSize: CGSize(width: 200, height: 20),
                                                    type: "Text")
    self.init(msgId: msgId,messageIDInt: messageID, messageStatus: messageStatus, fromUser: user, isOutGoing: isOutGoing, date: Date(), type: "Text", text: text, mediaPath: "", layout:  myLayout, duration: nil)
  }

  convenience init(voicePath: String, duration: CGFloat, isOutGoing: Bool, isNeedShowTime: Bool, msgId: String, messageID:Int,user: MyUser, messageStatus: IMUIMessageStatus) {
    let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                          isNeedShowTime: isNeedShowTime,
                                       bubbleContentSize: CGSize(width: 80, height: 37),
                                     bubbleContentInsets: UIEdgeInsets.zero,
                                    timeLabelContentSize: CGSize(width: 200, height: 20),
                                                    type: "Voice")
    self.init(msgId: msgId,messageIDInt: messageID, messageStatus: messageStatus, fromUser: user, isOutGoing: isOutGoing, date: Date(), type: "Voice", text: "", mediaPath: voicePath, layout:  myLayout, duration: duration)
  }
  
  convenience init(imagePath: String, isOutGoing: Bool, isNeedShowTime: Bool, msgId: String, messageID:Int, user: MyUser, messageStatus: IMUIMessageStatus) {
    
    var imgSize = CGSize(width: 120, height: 160)
    if let img = UIImage(contentsOfFile: imagePath) {
      imgSize = MyMessageModel.converImageSize(with: CGSize(width: (img.cgImage?.width)!, height: (img.cgImage?.height)!))
    }
    
    let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                          isNeedShowTime: isNeedShowTime,
                                       bubbleContentSize: imgSize,
                                     bubbleContentInsets: UIEdgeInsets.zero,
                                    timeLabelContentSize: CGSize(width: 200, height: 20),
                                       type: "Image")
    self.init(msgId: msgId,messageIDInt: messageID, messageStatus: messageStatus, fromUser: user, isOutGoing: isOutGoing, date: Date(), type: "Image", text: "", mediaPath: imagePath, layout:  myLayout, duration: nil)
  }
  
  convenience init(videoPath: String, isOutGoing: Bool) {
    let myLayout = MyMessageCellLayout(isOutGoingMessage: isOutGoing,
                                          isNeedShowTime: true,
                                       bubbleContentSize: CGSize(width: 120, height: 160),
                                     bubbleContentInsets: UIEdgeInsets.zero,
                                    timeLabelContentSize: CGSize(width: 200, height: 20),
                                                    type: "Video")
    let msgId = "\(NSDate().timeIntervalSince1970 * 1000)"
    self.init(msgId: msgId,messageIDInt: 0, messageStatus: .sending, fromUser: MyUser(), isOutGoing: isOutGoing, date: Date(), type: "Video", text: "", mediaPath: videoPath, layout:  myLayout, duration: nil)
  }
  
  override func text() -> String {
    return self.myTextMessage
  }
  
  static func calculateTextContentSize(text: String) -> CGSize {
    let textSize  = text.sizeWithConstrainedWidth(with: IMUIMessageCellLayout.bubbleMaxWidth, font: UIFont.systemFont(ofSize: 18))
    return textSize
  }
  
  static func calculateNameContentSize(text: String) -> CGSize {
    return text.sizeWithConstrainedWidth(with: 200,
                                         font: IMUIMessageCellLayout.timeStringFont)
  }
  
  static func converImageSize(with size: CGSize) -> CGSize {
    let maxSide = 160.0
    
    var scale = size.width / size.height
    
    if size.width > size.height {
      scale = scale > 2 ? 2 : scale
      return CGSize(width: CGFloat(maxSide), height: CGFloat(maxSide) / CGFloat(scale))
    } else {
      scale = scale < 0.5 ? 0.5 : scale
      return CGSize(width: CGFloat(maxSide) * CGFloat(scale), height: CGFloat(maxSide))
    }
  }
  
  /// Format chat date.
  static func formatChatDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.string(from: date)
  }

}


//MARK - IMUIMessageCellLayoutProtocol
class MyMessageCellLayout: IMUIMessageCellLayout {

  var type: String
  
  init(isOutGoingMessage: Bool, isNeedShowTime: Bool, bubbleContentSize: CGSize, bubbleContentInsets: UIEdgeInsets, timeLabelContentSize: CGSize,type: String) {
    self.type = type
    super.init(isOutGoingMessage: isOutGoingMessage,
               isNeedShowTime: isNeedShowTime,
               bubbleContentSize: bubbleContentSize,
               bubbleContentInsets: UIEdgeInsets.zero,
               timeLabelContentSize: timeLabelContentSize)
  }
  
  override var bubbleContentInset: UIEdgeInsets {
    if type != "Text" { return UIEdgeInsets.zero }
    if isOutGoingMessage {
      return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 15)
    } else {
      return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
    }
  }
  
  override var bubbleContentView: IMUIMessageContentViewProtocol {
    switch type {
    case "Text":
        return IMUITextMessageContentView()
    case "Image":
        return IMUIImageMessageContentView()
    case "Voice":
        return IMUIVoiceMessageContentView()
    case "Video":
        return IMUIVideoMessageContentView()
    case "Good":
        return IMUIProductContentView()
    case "MutilePart":
        return IMUIContractMessageContentView()
    case "File":
        return IMUIFileContentView()
    default:
        return IMUIDefaultContentView()
    }
  }
  
  override var bubbleContentType: String {
    return type
  }
  
}


