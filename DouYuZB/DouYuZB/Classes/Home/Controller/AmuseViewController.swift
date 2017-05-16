//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200
class AmuseViewController: BaseAnchorViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

//MARK:- 设置ui界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension AmuseViewController {
    override func loadData() {
        // 1, 给父类里面的ViewModel赋值
        baseVM = amuseVM
        // 2, 请求数据
        amuseVM.loadAllAmuseData {
            // 2.1, 刷新数据表格
            self.collectionView.reloadData()
            // 2.2, 调整数据 剔除第一个数据，最热数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groupModels = tempGroups
            
            // 3, 请求数据完成
            self.loadDataFinished()
        }
    }
}












