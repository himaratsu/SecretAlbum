//
//  Photo.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class Photo: RLMObject {
    
    dynamic var thumbnailPath: String = ""
    dynamic var fullPath: String = ""
    
    override init() {
        super.init()
    }
    
    init(thumbnailPath: String, fullPath: String) {
        self.thumbnailPath = thumbnailPath
        self.fullPath = fullPath
        super.init()
    }

}
