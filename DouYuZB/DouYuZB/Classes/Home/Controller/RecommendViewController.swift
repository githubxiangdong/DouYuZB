//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by new on 2017/4/25.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 5 // 间距
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin) / 2 //图片的宽
private let kItemH : CGFloat = kItemW * 0.6 + 3 * kItemMargin + 15  // item高度 15是字体label的高度
private let kNiceItemH : CGFloat = kItemW + 3 * kItemMargin + 15 // 颜值item的高度 15是字体label的高度
private let kHeaderH : CGFloat = 50 // 组头的高度
private let kAdViewH = kScreenW * 3/8 // 广告栏的高度

private let kNormalCellID = "kNormalCellID"
private let kNiceCellID = "kNiceCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        // 1, 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        // 2, 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //collectioView的宽高随着父控件的变化而变化
        
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "NiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNiceCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    fileprivate lazy var adView : RecommendAdv = {
        let adView = RecommendAdv.recommendAdv()
        adView.frame = CGRect(x: 0, y: -kAdViewH, width: kScreenW, height: kAdViewH)
        return adView
    }()
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置Ui界面
        setupUI()
        
        // 发送网络请求
        loadData()
    }
}

// MARK:- 设置Ui界面
extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        // 1, 将collectionView添加到view上
        view.addSubview(collectionView)
        
        // 2, 将adView添加到collectioView上
        collectionView.addSubview(adView)
        
        // 3, 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kAdViewH, 0, 0, 0)
    }
}

// MARK:- 请求数据
extension RecommendViewController {
    fileprivate func loadData() {
        
        // 1, 请求推荐数据
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
        
        // 2, 请求广告栏数据
        recommendVM.requestAds {
            self.adView.adsModels = self.recommendVM.adsModels
        }
    }
}

// MARK:- 调用 UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1, 取出模型对象
        let model = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        // 2, 定义cell
        var cell : BaseCollectionViewCell!
        
        // 3, 获取cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNiceCellID, for: indexPath) as! NiceCollectionViewCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        }
        
        // 4, 将模型赋给cell
        cell.model = model
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1, 取出header   
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView

        // 2, 取出模型
        header.model = recommendVM.anchorGroups[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        if indexPath.section == 1{
            
            return CGSize(width: kItemW, height: kNiceItemH)
        }else{
            
            return CGSize(width: kItemW, height: kItemH)
        }
    }
}




