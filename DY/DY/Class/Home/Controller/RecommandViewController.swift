//
//  RecommandViewController.swift
//  DY
//
//  Created by l on 2018/5/23.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
private let kItemMargin: CGFloat = 10
private let kHeaderViewH: CGFloat = 50
private let kNormalItemW = (kScreenW - 3*kItemMargin) / 2
private let kNormalItemH = kNormalItemW * 3 / 4

let KCollectionItemID = "KCollectionItemID"
let KCollectionHeaderID = "KCollectionHeaderID"

class RecommandViewController: UIViewController {

    lazy var collectionView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing =  0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KCollectionItemID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KCollectionHeaderID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: 0, width: kScreenW, height: contentH)
        self.view.frame = contentFrame
        print(self.view.bounds)
    }
}
extension RecommandViewController{
    func setupUI() {
        view.addSubview(collectionView)
    }
}
extension RecommandViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: KCollectionItemID, for: indexPath)
        item.backgroundColor = UIColor.red
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KCollectionHeaderID, for: indexPath)
        headerView.backgroundColor = UIColor.green
        return headerView
    }
}
