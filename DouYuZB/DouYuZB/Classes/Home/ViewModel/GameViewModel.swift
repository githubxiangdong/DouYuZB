//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class GameViewModel {
    
    lazy var gameModels : [GameModel] = [GameModel]()
}

//MARK:- 发送网络请求
extension GameViewModel {

    //MARK:- 请求游戏数据
    func loadAllGameData(_ finishCallBack : @escaping () -> ()) {
        
        // http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetworkTools.request(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            // 1, 将result转成字典
            guard let resultDic = result as? [String : Any] else{ return}
            // 2, 根据data的key得到数组
            guard let dataArr = resultDic["data"] as? [[String : Any]] else {return}
            // 3, 遍历数组里面的字典，将字典转模型
            for dic in dataArr {
                
                self.gameModels.append(GameModel(dic: dic))
            }
            // 4, 回调
            finishCallBack()
        }
    }
}
