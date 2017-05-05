//
//  NiceCollectionViewCell.swift
//  DouYuZB
//
//  Created by new on 2017/4/25.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
import Kingfisher

class NiceCollectionViewCell: BaseCollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet var cityBtn: UIButton!
    // MARK:- 定义模型属性
    override var model : AnchorModel? {
        didSet {
            // 1, 先将属性传给父类
            super.model = model
            // 2, 显示城市
            cityBtn.setTitle(model?.anchor_city, for: .normal)
        }
    }
}










