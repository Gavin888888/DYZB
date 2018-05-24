//
//  RecommendViewModel.swift
//  DY
//
//  Created by l on 2018/5/24.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    // MARK:- 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}
extension RecommendViewModel{
    func requestData(_ finishCallBack : @escaping () -> ()) {
        //请求参数
        let parameters = ["limit": "4","offset": "0","time":Date.getCurrentTime()]
        //创建Group
        let dGoup = DispatchGroup()
        
        dGoup.enter()
        print("第一部分 start")
        //请求推荐数据
        NetWorkTool.requestData(type: .Post, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",paramerts: parameters ) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }

            // 3.3.离开组
            dGoup.leave()
        }
        dGoup.enter()
        //请求第二部分数据
        print("第二部分 start")
        NetWorkTool.requestData(type: .Post, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",paramerts:  parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else { return }
            print("第二部分 end")
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGoup.leave()
        }
        dGoup.enter()
        //请求第三部分数据
        print("第三部分 start")
        NetWorkTool.requestData(type: .Post, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", paramerts: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else { return }
            print("第三部分 end")
            dGoup.leave()
        }
        dGoup.notify(queue: DispatchQueue.main) {
            print("所有请求已完成")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
    }
}
