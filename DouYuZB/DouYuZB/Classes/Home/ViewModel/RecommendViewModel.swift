//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by new on 2017/4/27.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]() // 主界面所有数据模型的数据源
    fileprivate lazy var hotModel : AnchorGroupModel = AnchorGroupModel()  // 热门数据模型
    fileprivate lazy var niceModel : AnchorGroupModel = AnchorGroupModel() // 颜值数据模型
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(_ finishCallBack : @escaping () -> ()) {
        // 1, 定义参数
        let parameters = ["limit" : "4" , "offest" : "0" , "time" : NSDate.getCurrentTime()]
        
        // 2, 创建异步group
        let group = DispatchGroup()
        
        // 3, 请求推荐的数据
        group.enter()// 进入第一组开始请求
        NetworkTools.request(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1, 将result转成字典
            guard let resultDic = result as? [String : NSObject] else{ return}
            // 2, 根据data的key,得到数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else{return}
            // 3, 遍历字典，获取字典，并将字典转成模型
            // 3.1 设置属性
            self.hotModel.tag_name = "热门"
            self.hotModel.icon_name = "home_header_hot"
            // 3.2 获取热门数据
            for dic in dataArr {
                let model = AnchorModel(dic: dic)
                self.hotModel.anchors.append(model)
            }
            // 4 离开组
            group.leave()
        }
        
        // 4, 请求颜值数据
        group.enter()// 进入第一组开始请求
        NetworkTools.request(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1, 将result转成字典
            guard let resultDic = result as? [String : NSObject] else{ return} // 校验字典resut能不能转成字典，转不成就返回
            
            // 2, 根据data该key，得到数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else{ return}
            
            // 3, 遍历字典，获取字典，并将字典转成模型
            // 3.1 设置属性
            self.niceModel.tag_name = "颜值"
            self.niceModel.icon_name = "home_header_phone"
            // 3.2 获取主播数据
            for dic in dataArr {
                let model = AnchorModel(dic: dic)
                self.niceModel.anchors.append(model)
            }
            // 4 离开组
            group.leave()
        }
        
        // 5, 请求2-12部分的游戏数据
        group.enter()// 进入第一组开始请求
        NetworkTools.request(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            // 1, 将result转成字典
            guard let resultDic = result as? [String : NSObject] else{ return} // 校验字典resut能不能转成字典，转不成就返回
            
            // 2, 根据data该key，得到数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else{ return}
            
            // 3, 遍历字典，获取字典，并且将字典转成模型
            for dic in dataArr {
                let groupM = AnchorGroupModel(dic: dic)
                self.anchorGroups.append(groupM)
            }
            
            //4 离开组
            group.leave()
        }
        
        
        // 6, 所有的数据请求完事后开始处理,将热门和颜值放到前面
        group.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.niceModel, at: 0)
            self.anchorGroups.insert(self.hotModel, at: 0)
            
            finishCallBack()
        }
    }
}











