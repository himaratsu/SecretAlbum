//
//  AlbumListCell.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {

    @IBOutlet weak private var thumbImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(album: Album) {
        titleLabel.text = album.title
    }
    
}
