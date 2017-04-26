//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by new on 2017/4/24.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate : class{
    func pageTitleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

// MARK:- 定义闭包
typealias pageTitleViewClosure = (Int) ->Void // 带参数

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2.0 // 滑块的高度
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85) //利用原数组定义一个颜色，默认是灰色
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0) //橙色

class PageTitleView: UIView {

    // MARK:- 定义属性
    fileprivate var currentIndex : Int = 0 // 当前点击的下标数
    fileprivate var titles : [String]      // 标题数组
    weak var delegate : PageTitleViewDelegate?
    
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
            
            // 5, 给lable添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        // 1，添加底线
        let lineH : CGFloat  = 0.5
        let bottomLine = UIView()
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

// MARK:- 监听label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tap : UITapGestureRecognizer) {
        // 0 ,获取当前的label
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        // 1, 如果是重复点击的同一个label就返回
        if currentLabel.tag == currentIndex { return}
        
        // 2, 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3, 切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        // 4, 保存最新label的下标值
        currentIndex = currentLabel.tag
        
        // 5, 滚动条的位置发生变化
        let scrollLineX = scrollLine.frame.width * CGFloat(currentIndex)
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6, 通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
    
        // 1, 取出sourceLabel和targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2, 处理底线滑块的逻辑
        let moveTotalSpace = targetLabel.frame.origin.x - sourceLabel.frame.origin.x // 滑块移动的总的距离
        let moveCurrentSpace = moveTotalSpace * progress // 滑块实时移动的距离
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveCurrentSpace
        
        // 3, 颜色的渐变
        // 3.1, 取出颜色变化的范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        // 3.2, 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        // 3.3, 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4, 记录最新的idnex
        currentIndex = targetIndex
    }
}






