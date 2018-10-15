//
//  MyUser.swift
//  IMUIChat
//
//  Created by oshumini on 2017/4/9.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import Foundation
import UIKit

class MyUser: NSObject, IMUIUserProtocol {

    var userAvata : String?
    var userName : String?
    var userIdString : String?
    var userClientId : String?
    var isOutGoing : Bool? = true
    public override init() {
        super.init()
    }
  
    func userId() -> String {
        
        return self.userIdString ?? ""
    }
  
    func displayName() -> String {
        
        return self.userName ?? ""
    }
  
    func Avatar() -> String {
        if !(self.isOutGoing!) {
            if self.userAvata == nil {
                return ""
            }else{
                return self.userAvata!
            }
        }else{
            return "guanfangkefu"
        }
        
    }
    func clientID() -> String {
        
        return self.userClientId ?? ""
    }
}
