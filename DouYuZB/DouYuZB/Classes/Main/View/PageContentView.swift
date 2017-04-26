//
//  PageContentView.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageContentViewDelegate : class { // 确保能被类调用
    func pageContentView(_ contentView : PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"
class PageContentView: UIView {

    // MARK:- 自定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentController : UIViewController
    fileprivate var startOffestX : CGFloat = 0 // 即将滑动时的偏移量
    fileprivate var isForbidScrollDelegate : Bool = false // 是否禁止scrolle的代理， 默认是no
    weak var delegate : PageContentViewDelegate?
    
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
        collectionView.delegate = self
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

// MARK:- 调用 UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffestX = scrollView.contentOffset.x // 将要开始滑动的偏移量
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 0, 判断是否是点击title带了的滑动
        if isForbidScrollDelegate { return}
        
        // 1,获取的数据
        var progress : CGFloat = 0 // 滑动的进度
        var sourceIndex : Int = 0 // 滑动前的下标
        var targetIndex : Int = 0 // 目标下标
        
        // 2，判断是左滑，还是右滑
        let currentOffestX = scrollView.contentOffset.x // 已经滑动的偏移量
        let scrollViewW = scrollView.frame.width
        let scale = currentOffestX / scrollViewW // 整个的比例
        if currentOffestX > startOffestX { // 表示左滑
            // 1, 计算progress
            progress = scale - floor(scale)
            // 2, 计算当前的 sourceIndex
            sourceIndex = Int(scale)
            // 3, 计算targetIndex
            targetIndex = sourceIndex + 1
            // 4, 判断目标下标有没有越界
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            // 5, 判断是否完全滑过去了
            if currentOffestX - startOffestX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{ // 表示右滑
            // 1, 计算progress
            progress = 1 - (scale - floor(scale))
            // 2, 计算targetIndex
            targetIndex = Int(scale)
            // 3, 计算sourceIndex
            sourceIndex = targetIndex + 1
            // 4, 判断sourceIndex是否越界
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3, 将progress/sourceIndex/targetIndex 传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(_ currentIndex : Int){
        // 1, 禁止滑动的协议
        isForbidScrollDelegate = true
        
        // 2, 根据点击title的下标，滑动到相应的位置
        let offestX = collectionView.frame.width * CGFloat(currentIndex)
        collectionView.setContentOffset(CGPoint(x: offestX, y: 0), animated: false)
    }
}




