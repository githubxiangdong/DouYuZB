//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by new on 2017/4/25.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    // MARK:- 控件属性
    @IBOutlet var icon: UIImageView!
    @IBOutlet var title: UILabel!
    
    //MARK:- 定义模型属性
    var model : AnchorGroupModel? {
        didSet {
            icon.image = UIImage(named: model?.icon_name ?? "home_header_normal")
            title.text = model?.tag_name
        }
    }
}
