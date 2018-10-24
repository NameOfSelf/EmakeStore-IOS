//
//  IMUINewInputViewDelegate.swift
//  EmakeServers
//
//  Created by 谷伟 on 2018/4/27.
//  Copyright © 2018年 谷伟. All rights reserved.
//
import Foundation
import UIKit
import Photos

@objc public protocol IMUINewInputViewDelegate: NSObjectProtocol {
    /**
     *  Tells the delegate that user tap send button and text input string is not empty
     */
    @objc optional func sendTextMessage(_ messageText: String)
    
    /**
     *  Tells the delegate that start record voice
     */
    @objc optional func startRecordVoice()
    
    /**
     *  Tells the delegate when finish record voice
     */
    @objc optional func finishRecordVoice(_ voicePath: String, durationTime: Double)
    
    /**
     *  Tells the delegate that user cancel record
     */
    @objc optional func cancelRecordVoice()
    
    /**
     *  Tells the delegate that IMUIInputView will switch to gallery
     */
    @objc optional func switchToGalleryMode(photoBtn: UIButton)
    
    /**
     *  Tells the delegate that user did selected Photo in gallery
     */
    @objc optional func didSeletedGallery()
    
    /**
     *  Tells the delegate that IMUIInputView will switch to camera mode
     */
    @objc optional func switchToCameraMode(cameraBtn: UIButton)
    
    /**
     *  Tells the delegate that user did shoot picture in camera mode
     */
    @objc optional func didSelectShootPicture()
    
    /**
     *  Tells the delegate when starting connvient reply
     */
    @objc optional func didSelectConnvientReply()
    
    /**
     *  Tells the delegate when starting go select product
     */
    @objc optional func didSelectProduct()
    /**
     *  Tells the delegate when starting go select order
     */
    @objc optional func didSelectOrder()
    /**
     *  Tells the delegate when starting go select end servers mode
     */
    @objc optional func didSelectEndServers()
    /**
     *  Tells the delegate when starting go select end servers mode
     */
    @objc optional func didSelectGroupPurchase()
    /**
     *  Tells the delegate when starting go select switch servers mode
     */
    @objc optional func didSelectSwitchServers()
    /**
     *  Tells the delegate that IMUIInputView will switch to emoji mode
     */
    @objc optional func switchToEmojiMode(cameraBtn: UIButton)
    
    /**
     *  Tells the delegate that user did seleted emoji
     */
    @objc optional func didSeletedEmoji(emoji: IMUIEmojiModel)
    
    /**
     *  Tells the delegate when starting record video
     */
    @objc optional func startRecordVideo()
    
    /**
     *  Tells the delegate when user did shoot video in camera mode
     */
    @objc optional func finishRecordVideo(videoPath: String, durationTime: Double)
    
    @objc optional func keyBoardWillShow(height: CGFloat, durationTime: Double)
    
    @objc optional func showOptionView()
}
