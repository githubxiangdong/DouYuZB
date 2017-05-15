//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    //MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    //MARK:- 构造函数
    override init() {
        
    }
    
    //MARK:- 自定义构造函数
    init(dic : [String : Any]) {
        
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
