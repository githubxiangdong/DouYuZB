//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by new on 2017/4/27.
//  Copyright © 2017年 9-kylins. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}
class NetworkTools {

    // 类方法
    class func request(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallBack : @escaping (_ result : Any) -> ()){
        
        // 1, 获取数据类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post // 三目运算
        
        // 2, 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (respone) in
            
            // 3, 获取结果
            guard let result = respone.result.value else{
            
                print(respone.result.error!)
                return;
            }
            
            // 4, 将结果回调出去
            finishedCallBack(result)
        }
    }
}
