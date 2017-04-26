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

private let kNormalCellID = "kNormalCellID"
private let kNiceCellID = "kNiceCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    // MARK:- 懒加载属性
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
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置Ui界面
        setupUI()
    }
}

// MARK:- 设置Ui界面
extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(collectionView)
    }
}

// MARK:- 调用 UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1, 定义cell
        var cell : UICollectionViewCell!
        
        // 2, 获取cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNiceCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        //
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1, 取出header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)

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




