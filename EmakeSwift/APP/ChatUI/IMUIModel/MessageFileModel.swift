//
//  MessageFileModel.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/10/16.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import ObjectMapper
class MessageFileModel: Mappable {
    var FileName : String?
    var FilePath : String?
    var FileSize : String?
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        
        FileName <- map["FileName"]
        FilePath <- map["FilePath"]
        FileSize <- map["FileSize"]
    }
}
