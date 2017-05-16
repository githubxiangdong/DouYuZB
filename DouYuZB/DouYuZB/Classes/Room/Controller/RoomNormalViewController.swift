//
//  RoomNormalViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController , UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.navigationBar.isHidden = true // 这个方法可以利用拖动手势返回
        navigationController?.setNavigationBarHidden(true, animated: true) // 此方法不可以
        // 保持pop手势，需要签UIGestureRecognizerDelegate代理
        // 在cunstonNavigation里面实现了全屏手势，所以这里的保持手势就屏蔽掉
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // 隐藏掉分栏控制器的tabbar
//        tabBarController?.tabBar.isHidden = true // 此方法会在pop回来时直接显示，没有动画，效果不是很好
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        // 隐藏掉分栏控制器的tabbar
        // 此方法会在pop回来时直接显示，没有动画，效果不是很好
        // 所以就在自定义的navigation里面隐藏掉tabbar
//        tabBarController?.tabBar.isHidden = false
    }
}
