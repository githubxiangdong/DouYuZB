//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kTopMArgin : CGFloat = 8
class FunnyViewController: BaseAnchorViewController {
    //MARK:- 懒加载viewModel
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMArgin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func loadData() {
        // 1, 给父类中的viewModel赋值
        baseVM = funnyVM
        
        // 2, 请求数据
        funnyVM.loadFunnyData {
            // 2.1, 刷新表格
            self.collectionView.reloadData()
            
            // 3, 请求数据完成
            self.loadDataFinished()
        }
    }
}








