//
//  STReplyModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/20.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class STReplyModel: Mappable {
    var AutoReply : String?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        AutoReply <- map["AutoReply"]
    }
    

}
