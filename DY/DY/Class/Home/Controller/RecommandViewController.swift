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
private let kNormalPrettyItemH = kNormalItemW * 4 / 3

let KCollectionItemID = "KCollectionItemID"
let KCollectionPrettyItemID = "KCollectionPrettyItemID"
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
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: KCollectionItemID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: KCollectionPrettyItemID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KCollectionHeaderID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loaddata()
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
    func loaddata()  {
        NetWorkTool.requestData(type: .Get, urlString: "http://service3.99melove.cn/sgzx-service/service/rest/tk.File/collection/upload") { (result) in
            print(result)
        }
    }
}
extension RecommandViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var item: UICollectionViewCell = UICollectionViewCell.init()
        if indexPath.section == 1 {
            item =  collectionView.dequeueReusableCell(withReuseIdentifier: KCollectionPrettyItemID, for: indexPath)
        }else
        {
            item = collectionView.dequeueReusableCell(withReuseIdentifier: KCollectionItemID, for: indexPath)
        }
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KCollectionHeaderID, for: indexPath)
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kNormalPrettyItemH)
        }else
        {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}
