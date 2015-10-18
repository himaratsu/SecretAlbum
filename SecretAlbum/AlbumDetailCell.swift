//
//  AlbumDetailCell.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class AlbumDetailCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
//        let localId = "37BACB30-B2B5-4CAE-B5A7-875D9A88E7DA_L0_001"
//        
//        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//        let imagePath = (doc as NSString).stringByAppendingPathComponent(localId)
//        print(imagePath)
//        let image = UIImage(contentsOfFile: imagePath)
//        imageView.image = image
    }
    
    func configure(photo: Photo) {
        let image = UIImage(contentsOfFile: photo.fullPath)
        imageView.image = image
    }
}
