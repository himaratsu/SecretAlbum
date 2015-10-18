//
//  AlbumDetailVC.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class AlbumDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    QBImagePickerControllerDelegate, MWPhotoBrowserDelegate {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    private let service = PhotoService()
//    var photos = [Photo]()
    var mwPhotos = [MWPhoto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.alwaysBounceVertical = true
        reload()
    }
    
    private func reload() {
        service.fetchPhotos { (results, error) -> Void in
            if let error = error {
                print("#### error is \(error)")
            } else {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func showZoomPhoto(index: Int) {
        let localId = "37BACB30-B2B5-4CAE-B5A7-875D9A88E7DA_L0_001"
        
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let imagePath = (doc as NSString).stringByAppendingPathComponent(localId)
        
        var photos = [MWPhoto]()
        for _ in 0...10 {
            let photo = MWPhoto(URL: NSURL(fileURLWithPath: imagePath))
            photos.append(photo)
        }
        mwPhotos = photos
        
        let browser = MWPhotoBrowser(delegate: self)
        navigationController?.pushViewController(browser, animated: true)

        browser.showNextPhotoAnimated(true)
        browser.showPreviousPhotoAnimated(true)
        browser.setCurrentPhotoIndex(UInt(index))
    }


    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = service.results?.count {
            return Int(count)
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let photo = service.results?.objectAtIndex(UInt(indexPath.row)) as? Photo {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AlbumDetailCell", forIndexPath: indexPath) as! AlbumDetailCell
            cell.configure(photo)
            return cell
        }
        fatalError()
    }
    
    
    // MARK: - Actions
    
    @IBAction func addPhotoButtonTouched(sender: AnyObject) {
        let picker = QBImagePickerController()
        picker.delegate = self
        picker.allowsMultipleSelection = true
        picker.showsNumberOfSelectedAssets = true
        
        presentViewController(picker, animated: true, completion: nil)
    }
 
    
    // MARK: - QBImagePickerControllerDelegate
    
    func qb_imagePickerController(imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        print("#### assets is \(assets.count)")
        
        for asset in assets {
            if let asset = asset as? PHAsset {
                let manager = PHImageManager.defaultManager()
                let options = PHImageRequestOptions()
                options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
                manager.requestImageForAsset(asset,
                    targetSize: PHImageManagerMaximumSize,
                    contentMode: PHImageContentMode.Default,
                    options: options,
                    resultHandler: { (image, info) -> Void in
                        if let image = image {
                            print("image.size \(image.size)")
                            self.saveImageToAppDocument(asset, image: image)
                        }
                })
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    private func saveImageToAppDocument(asset: PHAsset, image: UIImage) {
        let localId = asset.localIdentifier.stringByReplacingOccurrencesOfString("/", withString: "_")
        
        let doc = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let imagePath = (doc as NSString).stringByAppendingPathComponent(localId)
        
        if let data = UIImageJPEGRepresentation(image, 1.0) {
            data.writeToFile(imagePath, atomically: true)
            service.saveNewPhoto(localId, imagePath: imagePath)
        }
    }
    
    func qb_imagePickerControllerDidCancel(imagePickerController: QBImagePickerController!) {
        print("cancel")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showZoomPhoto(indexPath.row)
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.width
        let cellWidth = (width-3)/4
        return CGSizeMake(cellWidth, cellWidth)
    }
    
    
    // MARK: - MWPhotoBrowserDelegate

    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(mwPhotos.count)
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        if index < UInt(mwPhotos.count) {
            return mwPhotos[Int(index)]
        } else {
            return nil
        }
    }
}
