//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK:- 定义属性
    var contentView : UIView?
    //MARK:- 懒加载属性
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK:- 设置ui界面
extension BaseViewController {
    func setupUI() {
        // 1, 隐藏内容的view
        contentView?.isHidden = true
        // 2, 将动画添加到view上
        view.addSubview(animImageView)
        // 3, 执行动画
        animImageView.startAnimating()
        // 4, 设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        // 1, 先停止动画
        animImageView.stopAnimating()
        // 2, 隐藏掉animImageView
        animImageView.isHidden = true
        // 3, 显示内容view
        contentView?.isHidden = false
    }
}








