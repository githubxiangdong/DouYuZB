//
//  MainViewController.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("Home");
        addChildVc("Live");
        addChildVc("Focus");
        addChildVc("Discovery");
        addChildVc("Mine");
    }
    
    fileprivate func addChildVc(_ storyName : String){
        // 1,通过storyboard 获取控制器
        let childVc = UIStoryboard(name : storyName, bundle: nil).instantiateInitialViewController()!;
        
        // 2,将childVc作为自控制器
        addChildViewController(childVc);
    }
}
