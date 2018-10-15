//
//  IMUIFunctionCollectionViewCell.swift
//  EmakeServers
//
//  Created by 谷伟 on 2018/4/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class IMUIFunctionCollectionViewCell: UICollectionViewCell, IMUINewFeatureCellProtocol  {
    
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.layer.borderColor = BaseColor.SepratorLineColor.cgColor
        self.backView.layer.borderWidth = 1
        self.backView.layer.cornerRadius = 4
        self.optionTitle.textColor = TextColor_999999
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    func reloadOptionView(isOffcial: Bool) {
        
    }
}
