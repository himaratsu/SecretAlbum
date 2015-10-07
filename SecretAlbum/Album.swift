//
//  Album.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class Album: NSObject {

    let title: String
    let imagePath: String
    
    init(title: String, imagePath: String) {
        self.title = title
        self.imagePath = imagePath
    }
    
    class func dummy() -> Album {
        return Album(title: "Test", imagePath: "Sample")
    }
    
}
