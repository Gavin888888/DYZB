//
//  NSDate-Extension.swift
//  DY
//
//  Created by l on 2018/5/24.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
extension Date{
    static func getCurrentTime() -> String{
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
