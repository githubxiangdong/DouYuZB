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
    
    //MARK:- 控件属性
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UICollectionView!
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        
        // 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kAdCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout // 强转成flowlayout
        layout.itemSize = collectionView.bounds.size
        // 下面的代码在xib里面设置
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//        collectionView.isPagingEnabled = true
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
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAdCellId, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
}






