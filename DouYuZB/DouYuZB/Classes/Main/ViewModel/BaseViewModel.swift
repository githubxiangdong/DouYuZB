//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

extension BaseViewModel {
    
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping () -> ()) {
        
        NetworkTools.request(.get, URLString:URLString, parameters: parameters ) { (result) in
            
            // 1, 数据请求
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArr = resultDic["data"] as? [[String : Any]] else {return}
            
            // 2, 判断是否是分组数据
            if isGroupData {
                // 2.1, 字典转模型
                for dic in dataArr {
                    self.anchorGroups.append(AnchorGroupModel(dic: dic))
                }
            }else {
                // 2.1, 创建组模型
                let groupModel = AnchorGroupModel()
                // 2.2 字典转模型
                for dic in dataArr {
                    groupModel.anchors.append(AnchorModel(dic: dic))
                }
                // 2.3, 将groupModel添加到anchorGroups中
                self.anchorGroups.append(groupModel)
            }
            
            // 3, 回调
            finishedCallBack()
        }
    }
}



