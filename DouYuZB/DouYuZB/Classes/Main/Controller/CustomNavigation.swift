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
        
        //MARK:- 给pop添加全屏手势
        
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
        // 利用kvc取出属性
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {return}
        print(targetObjc)
        // 3.2 取出target
        guard let target = targetObjc.value(forKey: "target") else {return}
        
        // 3.3 取出action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4, 创建自己的pan手势
        let pan = UIPanGestureRecognizer()
        gestView.addGestureRecognizer(pan)
        pan.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 1, 隐藏掉分栏控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        // 2,
        super.pushViewController(viewController, animated: animated)
    }
}
