//
//  AnchorGroupModel.swift
//  DouYuZB
//
//  Created by new on 2017/4/27.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

// MARK:- 主播分组模型
class AnchorGroupModel: BaseGameModel {
    /// 该组中的房间信息
    var room_list : [[String : Any]]?{
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dic in room_list {
                
                anchors.append(AnchorModel(dic: dic))
            }
        }
    }
    /// 组显示的图标
    var icon_name : String = "home_header_normal" // 默认是此图标
    
    /// 创建主播模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
}








