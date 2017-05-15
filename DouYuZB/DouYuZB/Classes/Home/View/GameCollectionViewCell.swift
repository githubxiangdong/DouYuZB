//
//  GameCollectionViewCell.swift
//  DouYuZB
//
//  Created by new on 2017/5/8.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    //MARK:- 控件属性
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    //MARK: 定义模型属性
    var baseModel : BaseGameModel? {
    
        didSet {
        
            titleLabel.text = baseModel?.tag_name
            // 利用可选绑定判断是否存在图片地址
            if let iconUrl = URL(string: baseModel?.icon_url ?? ""){
                iconImageView.kf.setImage(with: iconUrl)
            }else{
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
}
