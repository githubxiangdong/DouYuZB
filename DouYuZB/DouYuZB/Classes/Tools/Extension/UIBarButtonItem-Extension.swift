//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

// 系统类扩展
extension UIBarButtonItem {

//    class func creatItem(imageName: String, highImageName: String, size: CGSize)->UIBarButtonItem{
//        
//        let btn = UIButton();
//        btn.frame = CGRect(origin: CGPoint.zero, size: size);
//        btn.setImage(UIImage(named: imageName), for: .normal);
//        btn.setImage(UIImage(named: highImageName), for: .highlighted);
//        
//        return UIBarButtonItem(customView: btn);
//    }
    
    // swift 
    // 便利构造函数：1>convenience开头 2>在构造函数中必须明确调用一个设计的构造函数（selg）
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        
        // 1，创建btn
        let btn = UIButton();
        
        // 2,设置btn的背景图片
        btn.setImage(UIImage(named: imageName), for: .normal);
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted);
        }
        
        // 3,设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit();
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size);
        }
    
        // 4,创建UIBarButtonItem
        self.init(customView: btn);
    }
    
}
