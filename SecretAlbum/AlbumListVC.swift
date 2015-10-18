//
//  AlbumListVC.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

class AlbumListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak private var tableView: UITableView!
    private let service = AlbumService()
    
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reload()
    }
    
    private func reload() {
        for _ in 1...10 {
            albums.append(Album.dummy())
        }
        tableView.reloadData()
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(AlbumListCell.self, indexPath: indexPath)
        cell.configure(albums[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    

}
