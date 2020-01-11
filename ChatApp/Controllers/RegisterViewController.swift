//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Eray on 11.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        print("doneButtonClicked")
    }
    
}
