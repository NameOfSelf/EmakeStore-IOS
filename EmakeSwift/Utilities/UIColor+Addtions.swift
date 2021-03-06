//
//  UIColor+Addtions.swift
//  SimpleSugareDemo
//
//  Created by panhongliu on 2017/5/3.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func HexColor(_ hexColor: Int32 ) -> UIColor {
        
        let r = CGFloat(((hexColor & 0x00FF0000) >> 16)) / 255.0
        let g = CGFloat(((hexColor & 0x0000FF00) >> 8)) / 255.0
        let b = CGFloat(hexColor & 0x000000FF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

func RGBColorWith(_ red : Int,green : Int, blue :Int) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
}

