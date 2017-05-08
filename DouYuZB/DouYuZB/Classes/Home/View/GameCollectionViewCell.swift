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
    var model : AnchorGroupModel? {
    
        didSet {
        
            titleLabel.text = model?.tag_name
            let iconUrl = URL(string: model?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "home_more_btn"))
        }
    }
}
