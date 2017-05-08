//
//  GameRecommendView.swift
//  DouYuZB
//
//  Created by new on 2017/5/8.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kCellID = "kCellID"
private let kEdgeInsetMargin : CGFloat = 10

class GameRecommendView: UIView {
    
    //MARK:- 定义数据属性
    var groupModels : [AnchorGroupModel]? { // 主播分类模型数据
     
        didSet {
            
            // 1, 移除前两组数据
            groupModels?.removeFirst()
            groupModels?.removeFirst()
            
            // 2, 添加个更多组的图标
            let moreModel = AnchorGroupModel()
            moreModel.tag_name = "更多"
            groupModels?.append(moreModel)
            
            // 3, 然后刷新数据
            collectionView.reloadData()
        }
    }
    
    //MARK:- 控件属性
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        // 注册cell
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
        
        // 给collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

//MARK:- 提供快速创建的类方法
extension GameRecommendView {
    class func gameRecommendView() -> GameRecommendView {
        return Bundle.main.loadNibNamed("GameRecommendView", owner: nil, options: nil)?.first as! GameRecommendView
    }
}

//MARK:- 遵守collectionView的数据源协议
extension GameRecommendView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! GameCollectionViewCell
        
        cell.model = groupModels![indexPath.item]
        
        return cell
    }
}






