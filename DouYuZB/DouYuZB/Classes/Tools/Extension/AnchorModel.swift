//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by new on 2017/4/27.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    /// 房间ID
    var room_id : Int = 0
    /// 房间对应的url
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 手机直播， 1 : 电脑直播
    var isVertical : Int = 0
    /// 房间名
    var room_name : String = ""
    /// 主播名称
    var nickname  : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city  : String = ""
    
    //MARK:- kvc 重写init方法
    init(dic : [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
