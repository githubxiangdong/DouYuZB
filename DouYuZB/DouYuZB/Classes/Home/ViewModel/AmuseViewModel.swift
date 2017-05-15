//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class AmuseViewModel {

    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

//MARK:- 发送网络请求
extension AmuseViewModel {
    
    func loadAllAmuseData(_ finishedCallBack : @escaping () -> ()){
        
        NetworkTools.request(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            
            // 1, 数据请求
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArr = resultDic["data"] as? [[String : Any]] else {return}
            
            // 2, 字典转模型
            for dic in dataArr {
                self.anchorGroups.append(AnchorGroupModel(dic: dic))
            }
            
            // 3, 回调
            finishedCallBack()
        }
    }
}
