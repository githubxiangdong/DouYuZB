//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2.0
class PageTitleView: UIView {

    // MARK:- 定义属性
    fileprivate var titles : [String]
    // MARK:- 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles:[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        // 设置ui界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置ui界面
extension PageTitleView{
    
    fileprivate func setupUI() {
        // 1,添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        // 2,添加titles
        setupTitleLabels()
        
        // 3，添加底线
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        
        // 0, 确定label的一些属性
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
            // 1,创建uilabel
            let label = UILabel()
            
            // 2,设置属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 3，设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4,将label添加到scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        // 1，添加底线
        let lineH : CGFloat  = 0.5
        let  bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2, 添加scrollLine
        //2.1，获取第一个label
        guard let firstLabel = titleLabels.first else {return} // 如果是空就返回 guard的用法
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        
    }
}









