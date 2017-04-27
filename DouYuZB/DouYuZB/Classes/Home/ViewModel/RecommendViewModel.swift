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
    fileprivate lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData() {
        // 1, 请求推荐的数据
        
        // 2, 请求颜值数据
        
        // 3, 请求2-12部分的游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4/&offest=0&time=1493286918
        NetworkTools.request(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4" , "offest" : "0" , "time" : NSDate.getCurrentTime()]) { (result) in
            // 1, 将result转成字典
            guard let resultDic = result as? [String : NSObject] else{ return} // 校验字典resut能不能转成字典，转不成就返回
            
            // 2, 根据data该key，得到数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else{ return}
            
            // 3, 遍历字典，获取字典，并且将字典转成模型
            for dic in dataArr {
                let group = AnchorGroupModel(dic: dic)
                self.anchorGroups.append(group)
            }
            
            print("-----")
        }
    }
}











