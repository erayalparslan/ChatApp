//
//  UINavigationControllerExtension.swift
//  ChatApp
//
//  Created by Eray on 13.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

extension UINavigationController{
    func openController(from storyboard: UIStoryboard, withIdentifier identifier: String, animated: Bool = true) {
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        pushViewController(viewController, animated: animated)
    }
}
