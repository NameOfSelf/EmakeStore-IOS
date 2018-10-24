//
//  STProductRecommendViewController.swift
//  EmakeSwift
//
//  Created by 谷伟 on 2018/9/28.
//  Copyright © 2018年 谷伟. All rights reserved.
//

import UIKit

class STProductRecommendViewController: BaseViewController {

    var leftTableView : UITableView?
    var rigthCollectionView : UICollectionView?
    let viewModel = STProductRecommendViewModel()
    var leftDataArray : [CategoryListModel]? = []
    var rightDataArray : [CategorySeriesModel]? = []
    var leftSelectIndex : NSInteger = 0
    var confirmButton : UIButton?
    var selectProduct : ProductItemModel?
    typealias selectProductBlock = (ProductItemModel?) -> Void
    var block : selectProductBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "全部商品"
        self.view.backgroundColor = .white
        self.baseSetNavLeftButtonIsBack()
        self.getStoreData()
        // Do any additional setup after loading the view.
    }

    override func configSubviews() {
        
        self.leftTableView = UITableView(frame: .zero, style: .plain)
        self.leftTableView?.delegate = self
        self.leftTableView?.dataSource = self
        self.leftTableView?.showsVerticalScrollIndicator = false
        self.leftTableView?.separatorColor = .clear
        self.leftTableView?.estimatedRowHeight = 0
        self.view.addSubview(self.leftTableView!)
        
        let layout = UICollectionViewFlowLayout()
        self.rigthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.rigthCollectionView?.delegate = self
        self.rigthCollectionView?.dataSource = self
        self.rigthCollectionView?.backgroundColor = .white
        self.rigthCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "item")
        self.view.addSubview(self.rigthCollectionView!)
        
        
        self.confirmButton = UIButton(type: .custom)
        self.confirmButton?.setTitle("确定", for: .normal)
        self.confirmButton?.setTitleColor(.white, for: .normal)
        self.confirmButton?.titleLabel?.font = AdaptFont(actureValue: 16)
        self.confirmButton?.layer.cornerRadius = WidthRate(actureValue: 4)
        self.confirmButton?.backgroundColor = BaseColor.APP_THEME_MAIN_COLOR
        self.confirmButton?.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        self.view.addSubview(self.confirmButton!)
    }
    
    override func snapSubviews() {
        
        self.leftTableView?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(HeightRate(actureValue: -65))
            make.width.equalTo(WidthRate(actureValue: 93))
        })
        
        
        self.rigthCollectionView?.snp.makeConstraints({ (make) in
            make.left.equalTo(WidthRate(actureValue: 94))
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(HeightRate(actureValue: -65))
        })
        
        self.confirmButton?.snp.makeConstraints({ (make) in
            make.width.equalTo(WidthRate(actureValue: 260))
            make.height.equalTo(HeightRate(actureValue: 40))
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(HeightRate(actureValue: -30))
        })
    }
    
    func getStoreData() {
        
        let storeId = UserDefaults.standard.object(forKey: EmakeStoreId) as! String
        let parameters: NSDictionary = ["StoreId":storeId]
        viewModel.getStoreProduct(self, pamameters: parameters) { (model) in
            let storeModel = model as! STProductRecommendModel
            self.leftDataArray = storeModel.CategoryList
            self.leftTableView?.reloadData()
            self.leftTableView?.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
            if (self.leftDataArray?.count)! > 0 {
                let model = self.leftDataArray![0]
                if (model.CategorySeries?.count)! > 0 {
                    self.rightDataArray = model.CategorySeries
                    self.rigthCollectionView?.reloadData()
                }
            }
        }
    }
    
    @objc func confirm() {
        
        self.block!(self.selectProduct)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension STProductRecommendViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.leftDataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.leftDataArray![indexPath.row]
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        let labelText = UILabel()
        labelText.text = model.CategoryName
        labelText.font = AdaptFont(actureValue: 12)
        labelText.frame = CGRect(x: WidthRate(actureValue: 7), y: 0, width: WidthRate(actureValue: 93), height: HeightRate(actureValue: 37))
        cell.addSubview(labelText)
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.backgroundColor = .white
        }else{
            cell.backgroundColor = TextColor_F7F7F7
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return HeightRate(actureValue: 38);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.leftDataArray![indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .white
        self.rightDataArray = model.CategorySeries
        if (self.rightDataArray?.count)! <= 0 {
            self.rightDataArray?.removeAll()
            self.rigthCollectionView?.reloadData()
        }else{
            self.rigthCollectionView?.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = TextColor_F7F7F7
    }
}
extension STProductRecommendViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.rightDataArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath)
        for view in item.subviews {
            view.removeFromSuperview()
        }
        let model = self.rightDataArray![indexPath.item]
        let itemImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: WidthRate(actureValue: 100), height: WidthRate(actureValue: 100)))
        itemImage.contentMode = .scaleAspectFit
        itemImage.sd_setImage(with: URL(string: model.GoodsSeriesIcon ?? ""))
        itemImage.layer.borderColor = BaseColor.SepratorLineColor.cgColor
        itemImage.layer.borderWidth = 1
        item.addSubview(itemImage)
        
        let imageSelect = UIImageView(image: UIImage(named: "select_no"))
        imageSelect.tag = 100
        item.addSubview(imageSelect)
        imageSelect.snp.makeConstraints { (make) in
            make.right.equalTo(WidthRate(actureValue: -11))
            make.width.equalTo(WidthRate(actureValue: 22))
            make.height.equalTo(WidthRate(actureValue: 22))
            make.top.equalTo(0)
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: HeightRate(actureValue: 90), width: WidthRate(actureValue: 100), height: HeightRate(actureValue: 47)))
        label.text = model.GoodsSeriesName
        label.font = AdaptFont(actureValue: 12)
        label.numberOfLines = 2
        label.textAlignment = .center
        item.addSubview(label)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return WidthRate(actureValue: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: WidthRate(actureValue: 110), height: HeightRate(actureValue: 127))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return HeightRate(actureValue: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(HeightRate(actureValue: 25), WidthRate(actureValue: 10), HeightRate(actureValue: 0), WidthRate(actureValue: 10))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.rightDataArray![indexPath.item]
        let product = ProductItemModel()
        product.GoodsSeriesName = model.GoodsSeriesName
        product.GoodsPriceValue = model.PriceRange
        product.GoodsImageUrl = model.GoodsSeriesIcon
        product.GoodsDetailUrl = "http://malldev.emake.cn:8004/ngoodsdetails/" + model.GoodsSeriesCode!
        self.selectProduct = product
        let cell = collectionView.cellForItem(at: indexPath)
        let imageselect = cell?.viewWithTag(100) as! UIImageView
        imageselect.image = UIImage(named: "select_yes")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let imageselect = cell?.viewWithTag(100) as! UIImageView
        imageselect.image = UIImage(named: "select_no")
    }

}
