//
//  ViewController.swift
//  ChatApp
//
//  Created by Eray on 11.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
}
//MARK: IBActions
extension ViewController{
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        if emailTextField.text != "" && passwordTextField.text != ""{
            loginUser()
        }
        else{
            ProgressHUD.show("Email/Password is missing")
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        if emailTextField.text != "" && passwordTextField.text != "" && repasswordTextField.text != ""{
            if passwordTextField.text == repasswordTextField.text{
                registerUser()
            }
            else{
                ProgressHUD.showError("Passwords mismatch!")
            }
            
        }
        else{
            ProgressHUD.showError("Email/Password/Re-password is missing")
        }
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
    
    private func cleanTextFields(){
        emailTextField.text      = nil
        passwordTextField.text   = nil
        repasswordTextField.text = nil
    }
    
    private func loginUser(){
        ProgressHUD.show("Login...")
        
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            if let error = error{
                ProgressHUD.showError(error.localizedDescription)
                return
            }
            else{
                self.openApp()
            }
        }
    }
    
    private func registerUser(){
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    private func openApp(){
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
            self.cleanTextFields()
            self.view.endEditing(true)
            
            //todo: present app
        }
    }
}
