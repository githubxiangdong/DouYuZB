//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by new on 2017/4/25.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kAdViewH = kScreenW * 3/8 // 广告栏的高度
private let kGameH :CGFloat = 90 // 游戏推荐的高度

class RecommendViewController: BaseAnchorViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var adView : RecommendAdv = {
        let adView = RecommendAdv.recommendAdv()
        adView.frame = CGRect(x: 0, y: -(kAdViewH + kGameH), width: kScreenW, height: kAdViewH)
        return adView
    }()
    fileprivate lazy var gameView : GameRecommendView = {
    
        let gameView = GameRecommendView.gameRecommendView()
        gameView.frame = CGRect(x: 0, y: -kGameH, width: kScreenW, height: kGameH)
        return gameView
    }()
}

// MARK:- 设置Ui界面
extension RecommendViewController {
    
    override func setupUI() {
        
        // 1,先调用super
        super.setupUI()
        
        // 2, 将adView添加到collectioView上
        collectionView.addSubview(adView)
        
        // 3, 将game添加到collectionView
        collectionView.addSubview(gameView)
        
        // 4, 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kAdViewH + kGameH, 0, 0, 0)
    }
}

// MARK:- 请求数据
extension RecommendViewController {

    override func loadData() {
        
        // 0, 给父类的viewModel赋值
        baseVM = recommendVM
        // 1, 请求推荐数据
        recommendVM.requestData {
            // 1, 展示推荐数据
            self.collectionView.reloadData()
            
            // 2, 将数据传给gameView
            var groups = self.recommendVM.anchorGroups
            // 2.1, 移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2, 添加个更多组的图标
            let moreModel = AnchorGroupModel()
            moreModel.tag_name = "更多"
            groups.append(moreModel)
            self.gameView.groupModels = groups
            
            // 3, 请求数据完成
            self.loadDataFinished()
        }
        
        // 2, 请求广告栏数据
        recommendVM.requestAds {
            self.adView.adsModels = self.recommendVM.adsModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    // 重写父类的返回cell的方法
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1, 取出niceCell
            let niceCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNiceCellID, for: indexPath) as! NiceCollectionViewCell
            // 2, 设置数据
            niceCell.model = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return niceCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kNiceItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}




