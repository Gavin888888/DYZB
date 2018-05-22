//
//  HomeViewController.swift
//  DY
//
//  Created by l on 2018/5/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //懒加载属性
    private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: 64, width: kScreenW, height: kNavigationBarH)
        let titles = ["推荐","游戏","娱乐","酷玩"]
        let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
//        titleView.backgroundColor = UIColor.purple
        return titleView
    }()
    //懒加载内容属性
    private lazy var pageContentView: PageContentView = {
        let pageContentViewFrame = CGRect(x: 0, y: pageTitleView.frame.maxY, width: kScreenW, height: kScreenH - pageTitleView.frame.maxY)
        var childVc = [UIViewController]
        for _ in 0..<4{
            let vc = UIViewController.init()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random(255.0)), g: <#T##CGFloat#>, b: <#T##CGFloat#>)
            
        }
        let contentView = PageContentView.init(frame: pageContentViewFrame, childVcs: <#T##[UIViewController]#>, parentViewController: <#T##UIViewController#>)
        contentView.backgroundColor = UIColor.red
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setUI()
    }
    //设置UI
    func setUI(){
        self.title = "直播"
        setNavigationBar()
        view.addSubview(self.pageTitleView)
        view.addSubview(pageContentView)
    }
    //设置导航栏
    func setNavigationBar() {
        setLeftBarButtonItem()
        setRightBarButtonItem()
    }
    //设置左边导航按钮
    func setLeftBarButtonItem() -> Void {
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.setImage(UIImage.init(named: "logo"), for: .normal)
        leftBtn.sizeToFit()
        let leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    //设置右边导航按钮
    func setRightBarButtonItem() -> Void {
        
        let rightView = UIView.init(frame: CGRect(x: 0, y: 0, width: 3*40, height: 40))
        
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.setImage(UIImage.init(named: "Image_scan"), for: .normal)
        rightBtn.setImage(UIImage.init(named: "Image_scan_click"), for: .highlighted)
        rightBtn.sizeToFit()
        rightBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        rightView.addSubview(rightBtn)
        
        let rightBtn1 = UIButton.init(type: .custom)
        rightBtn1.setImage(UIImage.init(named: "btn_search"), for: .normal)
        rightBtn1.setImage(UIImage.init(named: "btn_search_click"), for: .highlighted)
        rightBtn1.sizeToFit()
        rightBtn1.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        rightView.addSubview(rightBtn1)
        
        let rightBtn2 = UIButton.init(type: .custom)
        rightBtn2.setImage(UIImage.init(named: "image_my_history"), for: .normal)
        rightBtn2.setImage(UIImage.init(named: "Image_my_history_click"), for: .highlighted)
        rightBtn2.sizeToFit()
        rightBtn2.frame = CGRect(x: 80, y: 0, width: 40, height: 40)
        rightView.addSubview(rightBtn2)
    
        let rightBarButtonItem = UIBarButtonItem.init(customView: rightView)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
