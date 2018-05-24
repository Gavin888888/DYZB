//
//  CollectionViewPrettyCell.swift
//  DY
//
//  Created by l on 2018/5/23.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: UICollectionViewCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型属性
     var anchor : AnchorModel? {
        didSet {
                        
            // 2.所在的城市
//            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }
}
