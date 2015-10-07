//
//  Photo.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class Photo: NSObject {
    
    let thumbnailPath: String
    let fullPath: String
    
    init(thumbnailPath: String, fullPath: String) {
        self.thumbnailPath = thumbnailPath
        self.fullPath = fullPath
    }
    
    class func dummy() -> Photo {
        return Photo(thumbnailPath: "", fullPath: "")
    }

}
