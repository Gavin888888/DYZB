//
//  PageContentView.swift
//  DY
//
//  Created by l on 2018/5/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private var childVcs = [UIViewController]()
    private var parentVc:UIViewController
    
    init(frame: CGRect , childVcs:[UIViewController],parentViewController:UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentViewController
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
