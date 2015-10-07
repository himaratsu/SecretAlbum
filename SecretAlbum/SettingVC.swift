//
//  SettingVC.swift
//  SecretAlbum
//
//  Created by 平松　亮介 on 2015/10/07.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit
import Social

// TODO:
let kAppStoreId = "1045352003"
let kAppStoreUrl = "https://itunes.apple.com/app/id\(kAppStoreId)?mt=8"

class SettingVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    enum SectionType: Int {
        case Extension = 0
        case Help
        case AppInfo
        
        static func count() -> Int {
            return 3
        }
        
        func numberOfRows() -> Int {
            switch self {
            case Extension: return 3
            case Help: return 2
            case AppInfo: return 3
            }
        }
    }
    
    @IBOutlet weak private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SectionType.count()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionType = SectionType(rawValue: section) {
            return sectionType.numberOfRows()
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath)
        
        if let sectionType = SectionType(rawValue: indexPath.section) {
            switch sectionType {
            case .Extension:
                switch indexPath.row {
                case 0:
                    cell.accessoryType = .DisclosureIndicator
                    cell.textLabel?.text = "本パスワード"
                case 1:
                    cell.accessoryType = .DisclosureIndicator
                    cell.textLabel?.text = "偽パスワード"
                case 2:
                    cell.accessoryType = .DisclosureIndicator
                    cell.textLabel?.text = "Touch IDを利用"
                default: ()
                }
            case .Help:
                switch indexPath.row {
                case 0:
                    cell.accessoryType = .DisclosureIndicator
                    cell.textLabel?.text = "要望・質問を送る"
                case 1:
                    cell.accessoryType = .DisclosureIndicator
                    cell.textLabel?.text = "ヘルプ"
                default: ()
                }
            case .AppInfo:
                switch indexPath.row {
                case 0:
                    cell.textLabel!.text = "このアプリをレビューする"
                case 1:
                    cell.textLabel!.text = "友達に紹介する"
                case 2:
                    let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
                    cell.textLabel!.text = "アプリのバージョン: \(appVersion)"
                default: ()
                }
            }
            return cell
        } else {
            fatalError("not initialize")
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let sectionType = SectionType(rawValue: indexPath.section) {
            switch sectionType {
            case .Extension:
                switch indexPath.row {
                    //                case 0:
                    //                    HandShake.showCommentViewController(self)
                    //                case 1:
                    //                    HandShake.showHelpListViewController(self)
                default: ()
                }
            case .Help:
                switch indexPath.row {
//                case 0:
//                    HandShake.showCommentViewController(self)
//                case 1:
//                    HandShake.showHelpListViewController(self)
                default: ()
                }
            case .AppInfo:
                switch indexPath.row {
                case 0:
                    UIApplication.sharedApplication().openURL(NSURL(string: kAppStoreUrl)!)
                case 1:
                    showShareSheet()
                default: ()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SectionType.Extension.rawValue {
            return "パスワード"
        } else {
            return nil
        }
    }
    
    private func showShareSheet() {
        
        let shareText = "人気のラジオいろいろ聴ける。無料だしなかなかいい感じ！ #RadiTube"
        
        let alertController = UIAlertController(title: "RadiTubeを紹介する",
            message: nil,
            preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: "Twitter",
            style: .Default,
            handler: { (_) -> Void in
                self.shareTwitter(shareText)
        }))
        alertController.addAction(UIAlertAction(title: "Facebook",
            style: .Default,
            handler: { (_) -> Void in
                self.shareFacebook(shareText)
        }))
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "line://")!) {
            alertController.addAction(UIAlertAction(title: "LINE",
                style: .Default,
                handler: { (_) -> Void in
                    let message = "\(shareText):\(kAppStoreUrl)"
                    self.shareLINE(message)
            }))
        }
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Share SNS
    
    private func composeViewController(serviceType: String, message: String) -> SLComposeViewController {
        let vc = SLComposeViewController(forServiceType: serviceType)
        vc.setInitialText(message)
        vc.addURL(NSURL(string: kAppStoreUrl))
        vc.completionHandler = {
            (result: SLComposeViewControllerResult) -> () in
            switch (result) {
//            case .Done:
//                LimitManager.sharedManager.finishShareAction()
            default: ()
            }
        }
        
        return vc
    }
    
    private func shareTwitter(message: String) {
        let vc = composeViewController(SLServiceTypeTwitter, message:message)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    private func shareFacebook(message: String) {
        let vc = composeViewController(SLServiceTypeFacebook, message:message)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    private func shareLINE(message: String) {
        // line
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "line://")!) {
            let schemeUrl = "line://msg/text/\(message)"
            
            let encodedString = schemeUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            UIApplication.sharedApplication().openURL(NSURL(string: encodedString!)!)
        }
        else {
            UIAlertController.showAlertWithVC("LINEがインストールされていません", message: "", vc: self)
        }
    }
    
    
    // MARK: - Action
    
    @IBAction func closeButtonTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
