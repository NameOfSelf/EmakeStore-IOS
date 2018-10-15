//
//  IMUINewFeatureView.swift
//  EmakeServers
//
//  Created by 谷伟 on 2018/4/26.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos

private var CellIdentifier = ""

public enum IMUINewFeatureType {
    case emoji
    case option
    case voice
    case none
}
public protocol IMUINewFeatureViewDelegate: NSObjectProtocol {
    
    func didSelectPhoto()
    func didShotPicture()
    func didSeletedEmoji(with emoji: IMUIEmojiModel)
    func didSelectedConvenientReply()
    func didSelectedProfuct()
    func startRecordVoice()
    func didRecordVideo(with videoPath: String, durationTime: Double)
}

public protocol IMUINewFeatureCellProtocol {
    
    var featureDelegate: IMUINewFeatureViewDelegate? { set get }
    func activateMedia()
    func inactivateMedia()
}

public extension IMUINewFeatureCellProtocol {
    
    var featureDelegate: IMUINewFeatureViewDelegate? {
        
        get { return nil }
        set { }
    }
    
    func activateMedia() {}
    func inactivateMedia() {}
}

class IMUINewFeatureView: UIView {

    var view: UIView!
    var currentType:IMUINewFeatureType = .none
    @IBOutlet weak var featureCollectionView: UICollectionView!
    open weak var inputViewDelegate: IMUIInputViewDelegate?
    weak var delegate: IMUINewFeatureViewDelegate?
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAllViews()
    }
    func setupAllViews() {
        
        let bundle = Bundle.imuiNewInputViewBundle()
        self.featureCollectionView.register(UINib(nibName: "IMUIRecordVoiceCell", bundle: bundle), forCellWithReuseIdentifier: "IMUIRecordVoiceCell")
        self.featureCollectionView.register(UINib(nibName: "IMUIEmojiCell", bundle: bundle), forCellWithReuseIdentifier: "IMUIEmojiCell")
        self.featureCollectionView.register(UINib(nibName: "IMUIOptionCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "IMUIOptionCollectionViewCell")
        self.featureCollectionView.delegate = self
        self.featureCollectionView.dataSource = self
        self.featureCollectionView.reloadData()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let bundle = Bundle.imuiNewInputViewBundle()
        view = bundle.loadNibNamed("IMUINewFeatureView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    open func layoutFeature(with type: IMUINewFeatureType) {
        if currentType == type {
            return
        }
        currentType = type
        
        switch type {
            case .voice:
                self.layoutFeatureToRecordVoice()
                break
            case .option:
                self.layoutToOption()
                break
            case .emoji:
                self.layoutToEmoji()
                break
            case .none:
                self.layoutToNone()
                break
            default:
                break
        }
    }
    func layoutFeatureToRecordVoice() {
        self.featureCollectionView.bounces = false
        self.featureCollectionView.reloadData()
    }
    func layoutToOption() {
        self.featureCollectionView.bounces = true
        self.featureCollectionView.reloadData()
    }
    
    func layoutToEmoji() {
        self.featureCollectionView.bounces = true
        self.featureCollectionView.reloadData()
    }
    
    func layoutToNone() {
        self.featureCollectionView.reloadData()
    }
    
}
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension IMUINewFeatureView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch currentType {
        case .none:
            return 0
        default:
            return 1
        }
        
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentType {
        case .voice:
            CellIdentifier = "IMUIRecordVoiceCell"
        case .emoji:
            CellIdentifier = "IMUIEmojiCell"
            break
        default:
            CellIdentifier = "IMUIOptionCollectionViewCell"
            break
        }
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! IMUINewFeatureCellProtocol
        cell.activateMedia()
        cell.featureDelegate = self.delegate
        return cell as! UICollectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch currentType {
        default:
            return self.featureCollectionView.imui_size
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying: UICollectionViewCell, forItemAt: IndexPath) {
        let endDisplayingCell = didEndDisplaying as! IMUINewFeatureCellProtocol
        endDisplayingCell.inactivateMedia()
    }
    
    
}
