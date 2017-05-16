//
//  AmuseMenuView.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
private let kMenuCellID = "kMenuCellID"
class AmuseMenuView: UIView {
    
    //MARK:- 定义属性
    var groupModels : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
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
        
        collectionView.register(UINib(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    //MARK:- 不能在这里面设置layout的尺寸，collectionView的frame是不对的在这里面
    }
    //MARK:- 在layoutSubviews()里面设置layout
    override func layoutSubviews() {
        super.layoutSubviews()
        // 根据collectionView的layout设置layout.itemSize
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//MARK:- 快速创建AmuseMenuView的方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

//MARK:- 实现collectionView的数据源协议
extension AmuseMenuView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groupModels == nil { return 0 }
        let pageNum = (groupModels!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCellDataWithCell(cell : AmuseMenuCell, indexPath : IndexPath) {
        // 0页：0~7
        // 1页：8~15
        // 2页：16~23
        // 1, 取出起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        // 2, 判断越界的问题
        if endIndex > groupModels!.count - 1 { // 这个地方可以强制解包，因为如果是0的话，就不会到这个方法里面
            endIndex = groupModels!.count - 1
        }
        // 3, 给cell赋值
        cell.groupModels = Array(groupModels![startIndex...endIndex])// 数组范围的写法
    }
}

//MARK:- 实现collectionView的代理方法
extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / kScreenW)
    }
}











