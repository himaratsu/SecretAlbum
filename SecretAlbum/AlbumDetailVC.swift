//
//  AlbumDetailVC.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class AlbumDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reload()
    }
    
    private func reload() {
        for _ in 1...10 {
            photos.append(Photo.dummy())
        }
        collectionView.reloadData()
    }


    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AlbumDetailCell", forIndexPath: indexPath) as! AlbumDetailCell
        return cell
    }
    
    
    // MARK: - Actions
    
    @IBAction func addPhotoButtonTouched(sender: AnyObject) {
        // TODO: photo picker
    }
    
}
