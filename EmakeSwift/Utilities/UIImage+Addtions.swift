//
//  UIImage+Addtions.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/28.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func pressImageWithImage(image:UIImage,scaleSize:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(scaleSize)
        image.draw(in: CGRect(x: 0, y: 0, width: scaleSize.width, height: scaleSize.height))
        let pressImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return pressImage!
    }
}
