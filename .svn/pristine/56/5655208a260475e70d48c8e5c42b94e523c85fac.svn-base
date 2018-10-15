//
//  String+Addtions.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

extension String {
    subscript(range: CountableClosedRange<Int>) -> Substring {//闭区间
        let sIndex = range.lowerBound
        var eIndex = range.upperBound
        if sIndex > (count - 1) {
            return ""
        }else if eIndex > (count - 1) {
            eIndex = count - 1
        }
        let start = index(startIndex, offsetBy: sIndex)
        let end   = index(startIndex, offsetBy: eIndex)
        return self[start...end]
    }
    subscript(range: CountableRange<Int>) -> Substring {//开区间
        let sIndex = range.lowerBound
        var eIndex = range.upperBound
        if sIndex > (count - 1) {
            return ""
        }else if eIndex > (count - 1) {
            eIndex = count
        }
        let start = index(startIndex, offsetBy: sIndex)
        let end   = index(startIndex, offsetBy: eIndex)
        return self[start..<end]
    }
}
