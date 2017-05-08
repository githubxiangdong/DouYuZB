//
//  RecommendAdv.swift
//  DouYuZB
//
//  Created by new on 2017/5/5.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
private let kAdCellId = "kAdCellId"

class RecommendAdv: UIView {
    
    //MARK:- 定义属性
    var adsTimer : Timer?
    
    var adsModels : [AdsModel]? {
    
        didSet{
            // 1, 帅新collectionView
            collectionView.reloadData()
            
            // 2, 设置pageControl的个数
            pageControl.numberOfPages = adsModels?.count ?? 0
            
            // 3, 默认滚动到中间的某一位置
            let indexPath = IndexPath(item: (adsModels?.count ?? 0) * 10, section: 0) // 默认滚到总的个数*10的位置，往前滚得时候就会有数据
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // 4, 添加定时器
            removeAdsTimer() // 先删除再添加
            addAdsTimer()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()

        // 注册cell
        collectionView.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kAdCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout // 强转成flowlayout
        layout.itemSize = collectionView.bounds.size
    }
}

//MARK:- 提供一个快速创建view的类方法
extension RecommendAdv {
    class func recommendAdv() -> RecommendAdv {
        return Bundle.main.loadNibNamed("RecommendAdv", owner: nil, options: nil)?.first as! RecommendAdv
    }
}

//MARK:- 遵守collectionView的数据源协议
extension RecommendAdv: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (adsModels?.count ?? 0) * 10000 // 添加无限个数据，进行无限轮播
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAdCellId, for: indexPath) as! AdsCollectionViewCell
        // 取出模型数据
        cell.model = adsModels![indexPath.item % adsModels!.count] // 为了防止数组越界，下标取余 //这里不需要判断模型数据是否为0, 如为0，此协议里面是不会进来的
        return cell
    }
}

//MARK:- 遵守collectionView的代理方法
extension RecommendAdv: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 1, 获取滚动的偏移量
        let offestX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2, 计算pageControl的currentIndex
        pageControl.currentPage = Int(offestX / scrollView.bounds.width) % (adsModels?.count ?? 1) // 取余是不能为0的
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeAdsTimer() // 用户将要开始拖拽时移除定时器
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addAdsTimer() // 用户已经结束拖拽时添加定时器
    }
}

//MARK:- 对定时器的操作方法
extension RecommendAdv {
    
    fileprivate func addAdsTimer() {
    
        adsTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(adsTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeAdsTimer() {
        
        adsTimer?.invalidate() //从运行循环里面移除的定时器
        adsTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
    
        // 1, 获取滚动的偏移量
        let currentOffestX = collectionView.contentOffset.x
        let offestX = currentOffestX + collectionView.bounds.width
        
        // 2, 滚动位置
        collectionView.setContentOffset(CGPoint(x: offestX, y:0), animated: true)
    }
}




