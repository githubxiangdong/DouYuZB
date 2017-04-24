//
//  PageContentView.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView : PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}
private let ContentCellID = "ContentCellID"
class PageContentView: UIView {

    // MARK:- 自定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentController : UIViewController
   
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {
    
        // 1,创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2,创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentController: UIViewController) {
        self.childVcs = childVcs
        self.parentController = parentController
        super.init(frame: frame)
        
        // 设置ui
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置界面UI
extension PageContentView{
    
    fileprivate func setupUI() {
        
        // 1,将所有的子控制器添加到父控制器里面
        for childVc in childVcs {
            parentController.addChildViewController(childVc)
        }
        // 2, 添加一个uicollectionView用于存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- 调用 UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1, 创建cell
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2, 给cell赋值
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}






