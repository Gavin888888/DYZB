//
//  CollectionViewNormalCell.swift
//  DY
//
//  Created by l on 2018/5/23.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var model: AnchorModel?{
        didSet{
            guard let model = model else { return }
            titleLabel.text = model.nickname
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if model.online >= 10000 {
                onlineStr = "\(Int(model.online / 10000))万在线"
            } else {
                onlineStr = "\(model.online)在线"
            }
            onlineLabel.text = onlineStr
            subTitleLabel.text = model.room_name
            // 3.设置封面图片
            guard let iconURL = URL(string: model.vertical_src) else { return }
            imageView.kf.setImage(with: iconURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
