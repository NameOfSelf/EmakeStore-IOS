//
//  IMUIFileContentView.swift
//  EmakeServers
//
//  Created by 谷伟 on 2018/5/21.
//  Copyright © 2018年 谷伟. All rights reserved.
//
import Foundation
import UIKit
import ObjectMapper
public class IMUIFileContentView: UIView, IMUIMessageContentViewProtocol {
    
    var imageView = UIImageView()
    var fileName = UILabel()
    var fileSize = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(fileName)
        self.addSubview(fileSize)
        fileName.numberOfLines = 1
        imageView.contentMode = .scaleAspectFit
    }
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    public func layoutContentView(message: IMUIMessageModelProtocol) {
        
        imageView.frame = CGRect(x: 15, y:10, width: 42, height:42)
        fileName.font = UIFont.systemFont(ofSize: 14)
        fileName.frame = CGRect(x: 65, y:10, width: 160, height:20)
        fileSize.frame = CGRect(x: 65, y:33, width: 160, height:20)
        fileName.font = UIFont.systemFont(ofSize: 16)
        fileSize.font = UIFont.systemFont(ofSize: 14)
        if message.isOutGoing {
            fileName.textColor = UIColor.white
        }else{
            fileName.textColor = UIColor.black
        }
        let model = Mapper<MessageBodyModel>().map(JSONString: message.text())
        let fileModel = Mapper<MessageFileModel>().map(JSONString: (model?.Text)!)
        
        fileName.text = fileModel?.FileName
        fileSize.text = fileModel?.FileSize
        imageView.image = UIImage(named: "wenjian")
    }
}
