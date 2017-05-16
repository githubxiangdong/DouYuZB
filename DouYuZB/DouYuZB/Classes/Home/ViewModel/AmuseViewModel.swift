//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/15.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
    
}

//MARK:- 发送网络请求
extension AmuseViewModel {
    func loadAllAmuseData(_ finishedCallBack : @escaping () -> ()){
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") {
            finishedCallBack()
        }
    }
}
