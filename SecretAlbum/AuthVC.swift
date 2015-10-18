//
//  AuthVC.swift
//  SecretAlbum
//
//  Created by himara2 on 2015/10/11.
//  Copyright © 2015年 Ryosuke Hiramatsu. All rights reserved.
//

import UIKit

let AUTH_SUCCESS = "auth_success"
let AUTH_SUCCESS_DUMMY = "auth_success_dummy"

class AuthVC: UIViewController {

    @IBOutlet weak private var numberLabel: UILabel!
    private var numbers = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func appendNumbers(number: Int) {
        numbers = ("\(numbers)\(number)")
        numberLabel.text = numbers
        
        if numbers.utf16.count == 4 {
            authPassword(numbers)
        }
    }
    
    private func removeLastNumber() {
        numberLabel.text = numbers
    }
    
    private func authPassword(numbers: String) {
        if numbers == "8855" {
            NSNotificationCenter.defaultCenter().postNotificationName(AUTH_SUCCESS, object: nil)
        } else if numbers == "0000" {
            NSNotificationCenter.defaultCenter().postNotificationName(AUTH_SUCCESS_DUMMY, object: nil)
        } else {
            UIAlertController.showAlertWithVC("パスワードが違います", message: "もう一度入力してください", vc: self)
        }
    }
    

    // MARK: - Actions
    
    @IBAction func numberButtonTouched(sender: UIButton) {
        let tag = sender.tag
        appendNumbers(tag)
    }
    
    @IBAction func delButtonTouched(sender: AnyObject) {
        removeLastNumber()
    }

}
