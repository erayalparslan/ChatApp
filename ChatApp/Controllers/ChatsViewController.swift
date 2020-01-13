//
//  ChatsViewController.swift
//  ChatApp
//
//  Created by Eray on 13.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class ChatsViewController: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func composeButtonClicked(_ sender: Any) {
        navigationController?.openController(from: Constants.Storyboards.Contacts, withIdentifier: Constants.String.ViewController.ContactsViewController)
    }
    
    
}
