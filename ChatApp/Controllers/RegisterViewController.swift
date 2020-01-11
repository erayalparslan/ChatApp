//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Eray on 11.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit
import ProgressHUD

class RegisterViewController: BaseViewController{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var email = ""
    var password = ""
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        checkRegisteringUser()
    }
    
}

//MARK: UITextFieldDelegate
extension RegisterViewController{
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = super.textFieldShouldReturn(textField)
        let nextResponder: UIResponder? = textField.superview?.viewWithTag(textField.tag + 1)
        if nextResponder == nil{
            checkRegisteringUser()
        }
        return false
    }
}

//MARK: Helper Methods
extension RegisterViewController{
    private func setupViewController(){
        nameTextField.delegate = self
        surnameTextField.delegate = self
        countryTextField.delegate = self
        cityTextField.delegate = self
        phoneTextField.delegate = self
    }
    
    private func registerUser(){
        let fullName = nameTextField.text! + " " + surnameTextField.text!
        
        var tmpDictionary = [kFIRSTNAME: nameTextField.text!, kLASTNAME: surnameTextField.text!, kFULLNAME: fullName, kCOUNTRY: countryTextField.text!, kCITY: cityTextField.text!, kPHONE: phoneTextField.text!] as [String:Any]
        
        if avatarImage == nil{
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (newImage) in
                let encodedImage = newImage.jpegData(compressionQuality: 0.5)?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                tmpDictionary[kAVATAR] = encodedImage
            }
        }
        else{
            let encodedImage = avatarImage!.jpegData(compressionQuality: 0.5)?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            tmpDictionary[kAVATAR] = encodedImage
        }
        finishRegistration(withDictionary: tmpDictionary)
    }
    
    private func finishRegistration(withDictionary dictionary: [String: Any]){
        updateCurrentUserInFirestore(withValues: dictionary) { (error) in
            if let error = error{
                ProgressHUD.showError(error.localizedDescription)
            }
            else{
                ProgressHUD.showSuccess("Registration is successful")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID:FUser.currentId()])
                DispatchQueue.main.async {
                    PresentViewController.HomeTabbarController(vc: self)
                }
            }
        }
    }
    
    private func checkRegisteringUser(){
        self.view.endEditing(true)
        if nameTextField.text != nil && surnameTextField.text != nil && countryTextField.text != nil && cityTextField.text != nil && phoneTextField.text != nil{
            ProgressHUD.show("Registering...")
            FUser.registerUserWith(email: email, password: password, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                ProgressHUD.dismiss()
                if let error = error{
                    ProgressHUD.showError(error.localizedDescription)
                    
                }
                else{
                    self.registerUser()
                }
            }
        }
        else{
            ProgressHUD.showError("All fields are required")
        }
    }
}
