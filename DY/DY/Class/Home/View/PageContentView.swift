//
//  PageContentView.swift
//  DY
//
//  Created by l on 2018/5/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
let colltionCellID = "colltionCellID"
class PageContentView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        var colltionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        colltionView.delegate = self
        colltionView.dataSource = self
        colltionView.bounces = false
        colltionView.showsVerticalScrollIndicator = false
        colltionView.showsHorizontalScrollIndicator = true
        colltionView.isPagingEnabled = true
        colltionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:colltionCellID)
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        return colltionView
    }()
    private var childVcs = [UIViewController]()
    private var parentVc:UIViewController
    init(frame: CGRect , childVcs:[UIViewController],parentViewController:UIViewController) {
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
}

