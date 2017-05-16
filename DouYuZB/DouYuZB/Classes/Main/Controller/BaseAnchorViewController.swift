//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 5
private let kHeaderH : CGFloat = 50
let kNiceItemH : CGFloat = kItemW + 3 * kItemMargin + 15 // 颜值item的高度 15是字体label的高度
let kItemW : CGFloat = (kScreenW - 3*kItemMargin) / 2 //图片的宽
let kItemH : CGFloat = kItemW * 0.6 + 3 * kItemMargin + 15  // item高度 15是字体label的高度

private let kNormalCellID = "kNormalCellID"
private let kheaderViewID = "kheaderViewID"
let kNiceCellID = "kNiceCellID"

class BaseAnchorViewController: BaseViewController {

    //MARK:- 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        
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
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "NiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kNiceCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kheaderViewID)
        return collectionView
        }()
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }
}

//MARK:- 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        // 下面的顺序不能乱
        
        // 1, 给父类中的contentView的引用进行赋值
        contentView = collectionView
        // 2, 添加collectionView
        view.addSubview(collectionView)
        // 3, 调用 super.setupUI()
        super.setupUI()
    }
}

//MARK:- 请求数据
extension BaseAnchorViewController {
    func loadData() {
    }
}


//MARK:- 调用collectionView的数据源协议
extension BaseAnchorViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionViewCell
        
        cell.model = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kheaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.model = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

//MARK:- 遵守collectionView的代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1, 取出对应的主播模型
        let model = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        // 2, 判断是哪个房间
        model.isVertical == 0 ? pushRoomNormalVC() : presentShowRoomVC()
    }
    
    private func presentShowRoomVC() {
        // 1, 
        let showVC = RoomShowViewController()
        // 2, 
        present(showVC, animated: true, completion: nil)
    }
    private func pushRoomNormalVC() {
        // 1,
        let normalVC = RoomNormalViewController()
        // 2,
        navigationController?.pushViewController(normalVC, animated: true)
    }
}










