//
//  CustomNavigation.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class CustomNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1, 获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        // 2, 将获取的手势添加到view中的view
        guard let gestView = systemGes.view else {return}
        // 3, 获取target/action
        // 3.1 利用运行时机制，查看所有属性名称
        /*var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }*/
        // 3.2 利用kvc取出属性
        let targets = systemGes.value(forKey: "_targets")
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 1, 隐藏掉分栏控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        // 2,
        super.pushViewController(viewController, animated: animated)
    }
}
