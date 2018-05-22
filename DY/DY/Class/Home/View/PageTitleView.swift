//
//  PageTitleView.swift
//  DY
//
//  Created by l on 2018/5/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    //懒加载属性
    private lazy var scrollView : UIScrollView = {
        var scrollView = UIScrollView.init()
        scrollView.frame = self.bounds
        scrollView.bounces = false
//        scrollView.backgroundColor = UIColor.red
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView.init()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    private lazy var titleLabel:[UILabel] = [UILabel]()
    
    //存储属性
    private var titles: [String]
    //初始化
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        //必须调用一个系统的初始化方法
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitleView {
    //设置UI
    func setUI() {
        //1.添加scrollView
        addSubview(scrollView)
        //2.添加label
        setupTitleLabel()
        //3.设置底部分割线
        setupBottomLine()
    }
    //设置label
    func setupTitleLabel()  {
        //0.设置初始值
        let labelY = 0
        let labelW = kScreenW/CGFloat(titles.count)
        let labelH = self.bounds.height
        
        for (index , title) in titles.enumerated(){
            //1.创建label
            let label = UILabel.init()
            //2.设置label的属性
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.black
            label.text = title
            //3.设置label的frame
            let labelX = CGFloat(index)*labelW
            label.frame = CGRect(x: labelX, y: CGFloat(labelY), width: labelW, height: labelH)
            //4.把label添加到scrollView上
            scrollView.addSubview(label)
            titleLabel.append(label)
        }
    }
    //设置bottomLine
    func setupBottomLine() {
        let bottomLineH: CGFloat = 1
        let bottomLineView = UIView.init(frame: CGRect(x: 0, y: self.bounds.height - bottomLineH, width: kScreenW, height: bottomLineH))
        bottomLineView.backgroundColor = UIColor.gray
        addSubview(bottomLineView)
        
        //添加滑块
        guard let firtLabel = titleLabel.first else {
            return
        }
        firtLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        let scrollLineH:CGFloat = 4
        scrollLine.frame = CGRect(x: firtLabel.frame.origin.x, y: scrollView.frame.size.height - scrollLineH, width: firtLabel.bounds.width, height: scrollLineH)
        print(scrollLine.frame)
    }
    
}
