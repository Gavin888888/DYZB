//
//  PageContentView.swift
//  DY
//
//  Created by l on 2018/5/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate: class {
    func pageContentViewDidChange(progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}
let colltionCellID = "colltionCellID"
class PageContentView: UIView ,UICollectionViewDataSource{
    //设置代理
    weak var delegate: PageContentViewDelegate?
    //记录滑动开始位置
    private var start_offSet_x: CGFloat = 0
    private lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        var colltionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        colltionView.delegate = self
        colltionView.dataSource = self
        colltionView.bounces = false
        colltionView.showsVerticalScrollIndicator = false
        colltionView.showsHorizontalScrollIndicator = false
        colltionView.isPagingEnabled = true
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:colltionCellID)
        layout.itemSize = self!.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        return colltionView
    }()
    private var childVcs = [UIViewController]()
    private weak var parentVc:UIViewController?
    init(frame: CGRect , childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageContentView{
    func setupUI() {
        addSubview(collectionView)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colltionCellID, for: indexPath)
    
        cell.addSubview(childVcs[indexPath.row].view)
        return cell
    }
    func setCurrentVc(currentIndex:Int) {
        let offset_X = CGFloat(currentIndex)*self.bounds.width
        collectionView.setContentOffset(CGPoint(x: offset_X, y: 0), animated: false)
    }
}
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        start_offSet_x = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var  progress: CGFloat = 0
        var  sourceIndex: Int = 0
        var  targetIndex: Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > start_offSet_x  {
            progress =  currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count  - 1
            }
            if currentOffsetX - start_offSet_x == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else
        {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
        print("---\(progress)+\(sourceIndex)+\(targetIndex)")
        delegate?.pageContentViewDidChange(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

