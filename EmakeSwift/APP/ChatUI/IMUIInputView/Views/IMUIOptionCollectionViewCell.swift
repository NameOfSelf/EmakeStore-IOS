//
//  IMUIOptionCollectionViewCell.swift
//  EmakeServers
//
//  Created by 谷伟 on 2018/4/27.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class IMUIOptionCollectionViewCell: UICollectionViewCell , IMUINewFeatureCellProtocol{
    
    
    var featureDelegate: IMUINewFeatureViewDelegate?
    @IBOutlet weak var functionCollectionView: UICollectionView!
    var isOffcial : Bool = false
    let optionArray = ["快捷回复","相册","拍照","买家订单","商品推荐","团购推荐","咨询转移","结束对话"]
    let optionImageArray = ["icon_chat_reply","icon_image","icon_photograph","icon_ Orders","icon_commodity_recommendation","tuangoutuijian","呼叫转移","结束"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let bundle = Bundle.imuiNewInputViewBundle()
        self.functionCollectionView.register(UINib(nibName: "IMUIFunctionCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "IMUIFunctionCell")
        functionCollectionView.delegate = self
        functionCollectionView.dataSource = self
        self.backgroundColor = RGBColorWith(246, green: 246, blue: 248)
        self.functionCollectionView.reloadData()
    }
    func reloadOptionView(isOffcial: Bool) {
        self.isOffcial = isOffcial
        self.functionCollectionView.reloadData()
    }
}
extension IMUIOptionCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isOffcial {
            return 3
        }
        return 8
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(25, 30, 25, 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 52, height: 78)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMUIFunctionCell", for: indexPath) as! IMUIFunctionCollectionViewCell
        cell.optionTitle.text = optionArray[indexPath.item]
        cell.optionImage.image = UIImage(named: optionImageArray[indexPath.item])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        
        case 0:
            self.featureDelegate?.didSelectedConvenientReply()
        case 1:
            self.featureDelegate?.didSelectPhoto()
        case 2:
            self.featureDelegate?.didShotPicture()
        case 3:
            self.featureDelegate?.didSelectedOrder()
        case 4:
            self.featureDelegate?.didSelectedProfuct()
        case 5:
            self.featureDelegate?.didSelectedGroupPurchase()
        case 6:
            self.featureDelegate?.didSelectedServerSwitch()
        case 7:
            self.featureDelegate?.didSelectedEndServers()
        default:
            break
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath) {
    }
    
}

