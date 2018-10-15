//
//  IMUIContractMessageContentView.swift
//  emake
//
//  Created by 谷伟 on 2017/11/13.
//  Copyright © 2017年 emake. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
public class IMUIContractMessageContentView: UIView, IMUIMessageContentViewProtocol {
    
    var imageView = UIImageView()
    
    var textMessageLable = UILabel()
    open static var outGoingTextColor = UIColor.white
    open static var inComingTextColor = UIColor.black
    open static var outGoingTextFont = UIFont.systemFont(ofSize: 18)
    open static var inComingTextFont = UIFont.systemFont(ofSize: 18)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(textMessageLable)
        textMessageLable.numberOfLines = 1
        
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layoutContentView(message: IMUIMessageModelProtocol) {
        print("layoutContentView---\(message.text())")
        let model = Mapper<MessageBodyModel>().map(JSONString: message.text())
        textMessageLable.text = model?.Text;
        textMessageLable.textColor = UIColor.black
        textMessageLable.textAlignment = .center;
        textMessageLable.font = IMUITextMessageContentView.outGoingTextFont
        textMessageLable.frame = CGRect.init(x: 0, y: 0, width: message.layout.bubbleContentSize.width, height: 23)
        imageView.frame = CGRect(x: 0, y:30, width: message.layout.bubbleContentSize.width, height:message.layout.bubbleContentSize.height-31)
        if model?.Image != nil{
            imageView.sd_setImage(with:NSURL.init(string: model?.Image ?? "") as URL?, completed: nil)
        }
        
    }
}
