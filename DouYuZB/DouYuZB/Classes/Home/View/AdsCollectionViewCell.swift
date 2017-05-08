//
//  AdsCollectionViewCell.swift
//  DouYuZB
//
//  Created by new on 2017/5/8.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var model : AdsModel? {
    
        didSet {
        
            // 0, 校验模型是否有值
            guard let model = model else { return }
            // 1, 显示文字
            titleLabel.text = model.title
            // 2,显示图片
            let iconUrl = URL(string: model.pic_url)
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "Img_default"))
        }
    }
}
