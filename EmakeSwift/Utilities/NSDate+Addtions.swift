//
//  NSDate+Addtions.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/4/11.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

extension NSDate{
    //获取当前时间
    func getCurrentTime() -> String {
        
        let nowTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: nowTime)
    }
    //获取当前时间的时间戳
    func getCurrentTimeInterval() -> Int {
        
        let nowTime = Date()
        let timeInterval:TimeInterval = nowTime.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    //时间戳转时间(格式：YYYY-MM-dd HH:mm:ss)
    func changeTimeIntervalToTimeString(_ timeStamp:Int) -> String {
        
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    //时间戳转时间(格式：YYYY-MM-dd HH:mm:ss)
    func changeTimeIntervalToTimeStringAnother(_ timeStamp:Int) -> String {
        
        let timeInterval:TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    //时间是否在有效期内，validTimeInterval：分钟
    func isTimeValid(lastTime:String,currentTime:String,validTimeInterval:Int) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateLastTime =  dateFormatter.date(from: lastTime)
        let dateCurrentTime = dateFormatter.date(from: currentTime)
        let intervalLastTime = dateLastTime?.timeIntervalSince1970
        let intervalCurrentTime = dateCurrentTime?.timeIntervalSince1970
        let intervalDistance = Int(intervalCurrentTime!) - Int(intervalLastTime!)
        let minute = intervalDistance/60
        if minute > validTimeInterval{
            return false
        }
        return true
    }
}
