
//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by new on 2017/4/27.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
     
        return "\(interval)" // 转字符串
    }
}
