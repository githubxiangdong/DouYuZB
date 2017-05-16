//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性 利用闭包
    fileprivate lazy var pageTitleView : PageTitleView = {
        
        let titleFrame = CGRect(x: 0, y:kStatusBarH + kNavigationBarH, width: kScreenW, height:kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var contentView : PageContentView = {
       
        // 1, 确定内容frame
        let contentY = kStatusBarH + kNavigationBarH + kTitleViewH
        let contentH = kScreenH - contentY - kTabBarH
        let contentFtame = CGRect(x: 0, y: contentY, width: kScreenW, height: contentH)
        
        // 2，确定所有自己控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let contentView = PageContentView(frame: contentFtame, childVcs: childVcs, parentController: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI();
    }
}

// MARK:- 设置ui界面
extension HomeViewController{
    
    fileprivate func setupUI() {
        // 0, 不需要调整UIScrollView上的内边距
        automaticallyAdjustsScrollViewInsets = false;
        // 1, 设置导航栏
        setupNavigationBar();
        // 2, 添加titleView
        view.addSubview(pageTitleView)
        // 3, 添加contentView
        view.addSubview(contentView)
        contentView.backgroundColor = UIColor.purple
    }
    
    fileprivate func setupNavigationBar() {
        // 1,设置左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        // 2, 设置右边的item
        let size = CGSize(width: 40, height: 40);
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size);
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size);
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size);
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
    }
}

// MARK:- 调用  PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{

    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
// MARK:- 调用 PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}





