//
//  BaseCollectionViewCell.swift
//  DouYuZB
//
//  Created by new on 2017/5/5.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK:- 控件属性
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var onlineBtn: UIButton!
    
    // MARK:- 定义模型
    var model : AnchorModel? {
        didSet { // 监听属性的改变
            // 0, 校验模型是否有至
            guard let model = model else { return}
            // 1， 取出在线人数显示的文字
            var onlineStr : String = ""
            if model.online >= 10000 {
                onlineStr = "\(Int(model.online / 10000))万在线"
            }else{
                onlineStr = "\(model.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 2,
            nickNameLabel.text = model.nickname
            // 3, 显示图片
            guard let iconUrl = URL(string: model.vertical_src) else{ return}
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
