//
//  AlbumService.swift
//  SecretAlbum
//
//  Created by himara2 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class AlbumService: NSObject {

    func saveNewAlbum(albumTitle: String) {
        let album = Album(title: albumTitle, imagePath: "")
        album.createdAt = NSDate()
        
        let realm = RLMRealm.defaultRealm()
        realm.transactionWithBlock({ () -> Void in
            realm.addObject(album)
        })
    }
    
    func fetchAlbums(completionHandler:((RLMResults?, NSError?) -> Void)) {
        let albums = Album.allObjects()
        completionHandler(albums, nil)
    }
}
