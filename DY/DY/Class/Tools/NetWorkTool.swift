//
//  NetWorkTool.swift
//  DY
//
//  Created by l on 2018/5/23.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case Post
    case Get
}
class NetWorkTool {
    class func requestData(type: MethodType, urlString: String , paramerts: [String: Any]? = nil,finishedCallBack: @escaping (_ result : Any) -> ()) {
        let method = type == MethodType.Post ? HTTPMethod.post : HTTPMethod.get
        
        Alamofire.request(urlString, method: method, parameters: paramerts).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallBack(result)
        }
    }
}
