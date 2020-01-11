//
//  BaseViewController.swift
//  jkt
//
//  Created by MacbookPro on 5.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureToView()
    }
    
    private func addGestureToView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
}

extension BaseViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1
        let nextResponder: UIResponder? = textField.superview?.viewWithTag(nextTag)
        if (nextResponder != nil) {
            nextResponder!.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
