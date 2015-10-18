//
//  PhotoService.swift
//  SecretAlbum
//
//  Created by himara2 on 2015/10/18.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class PhotoService: NSObject {

    var results: RLMResults?
    
    func saveNewPhoto(identifier: String, imagePath: String) {
        let photo = Photo(thumbnailPath: "", fullPath: imagePath)
        
        let realm = RLMRealm.defaultRealm()
        realm.transactionWithBlock({ () -> Void in
            realm.addObject(photo)
        })
    }

    func fetchPhotos(completionHandler:((RLMResults?, NSError?) -> Void)) {
        self.results = Photo.allObjects()
        completionHandler(results, nil)
    }
}
