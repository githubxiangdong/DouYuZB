//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 5
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin) / 2 //图片的宽
private let kItemH : CGFloat = kItemW * 0.6 + 3 * kItemMargin + 15  // item高度 15是字体label的高度
private let kHeaderH : CGFloat = 50
private let kNormalCellID = "kNormalCellID"
private let kheaderViewID = "kheaderViewID"

class AmuseViewController: UIViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // 1, 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        // 2, 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //collectionView的宽高可以随着父控件宽高的变化而变化
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kheaderViewID)
        return collectionView
    }()
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1,
        setupUI()
        
        // 2, 
        loadData()
    }
}

//MARK:- 设置UI界面
extension AmuseViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK:- 请求数据
extension AmuseViewController {
    func loadData() {
        amuseVM.loadAllAmuseData { 
            self.collectionView.reloadData()
        }
    }
}

//MARK:- 调用collectionView的数据源协议
extension AmuseViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        cell.model = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kheaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.model = amuseVM.anchorGroups[indexPath.section]
        return headerView
    }
}










