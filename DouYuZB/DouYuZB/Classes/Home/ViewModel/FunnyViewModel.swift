//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by new on 2017/5/16.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallBack : @escaping () -> ()) {
        //http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offest=0
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offest" : 0]) {
            finishedCallBack()
        }
    }
}
