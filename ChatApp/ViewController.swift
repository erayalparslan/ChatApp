//
//  ViewController.swift
//  ChatApp
//
//  Created by Eray on 11.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    
    
    
    
}
//MARK: IBActions
extension ViewController{
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        print("loginButtonClicked")
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        print("registerButtonClicked")
    }
}

//MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField{
            repasswordTextField.becomeFirstResponder()
        }
        else if textField == repasswordTextField{
            //todo
        }
        return true
    }
}

//MARK: Helper Methods
extension ViewController{
    private func setupViewController(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repasswordTextField.delegate = self
    }
}
