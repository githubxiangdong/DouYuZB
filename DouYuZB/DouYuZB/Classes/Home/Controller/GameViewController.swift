//
//  GameViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewId = "kHeaderViewId"

class GameViewController: UIViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // 1, 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2, 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
    
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.title.text = "常见"
        headerView.icon.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : GameRecommendView = {
        let gameView = GameRecommendView.gameRecommendView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1,
        setupUI()
        // 2,
        loadData()
    }
}

//MARK:- 设置ui界面
extension GameViewController {
    
    fileprivate func setupUI() {
    
        // 1, 将collectionView添加到view上
        view.addSubview(collectionView)
        // 2, 添加顶部的headerView
        collectionView.addSubview(topHeaderView)
        // 3, 将常见游戏的view添加到collectionView上
        collectionView.addSubview(gameView)
        // 3, 设置collectionView的内边距,保证加在上面的头视图可以显示
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 请求数据
extension GameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            // 1, 展示全部游戏
            self.collectionView.reloadData()
            
            // 2, 展示常见游戏
            let groups = self.gameVM.gameModels[0..<10]// 将前10条数据取出来，不用利用for循环取出
            self.gameView.groupModels = Array(groups)
        }
    }
}

//MARK:- 调用collectionView的数据源协议
extension GameViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! GameCollectionViewCell
        cell.baseModel = gameVM.gameModels[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1, 取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! CollectionHeaderView
        // 2, 
        headerView.title.text = "全部"
        headerView.icon.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}






