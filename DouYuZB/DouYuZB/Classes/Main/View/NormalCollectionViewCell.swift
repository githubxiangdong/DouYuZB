//
//  NormalCollectionViewCell.swift
//  DouYuZB
//
//  Created by new on 2017/4/25.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet var roomNameLabel: UILabel!
    
    //MARK:- 定义模型属性
    override var model : AnchorModel? {
        didSet {
            super.model = model
            // 房间名称
            roomNameLabel.text = model?.room_name
        }
    }
}
