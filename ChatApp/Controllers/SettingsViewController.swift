//
//  SettingsViewController.swift
//  ChatApp
//
//  Created by Eray on 11.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit
import ProgressHUD

class SettingsViewController: BaseViewController{
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        FUser.logOutCurrentUser { (success) in
            if success{
                PresentViewController.LoginViewController(vc: self)
            }
            else{
                ProgressHUD.showError("Logout failed")
            }
        }
    }
}
