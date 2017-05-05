//
//  AdsModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/5.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class AdsModel: NSObject {

    // 标题
    var title : String = ""
    // 图片地址
    var pic_url  : String = ""
    // 主播信息对应的模型字典
    var room : [String : AnyObject]? {
        didSet {
            guard let room = room else { return}
            anchor = AnchorModel(dic: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    //MARK:- 自定义构造函数
    init(dic : [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
