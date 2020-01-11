//
//  UIViewControllerExtension.swift
//  ChatApp
//
//  Created by Eray on 11.01.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import UIKit

extension UIViewController{
    
    struct PresentViewController{
        struct TabbarController{
            static func HomeTabbarController(vc: UIViewController){
                if let tabbarController = Constants.Storyboards.Home.instantiateViewController(withIdentifier: Constants.String.TabbarController.HomeTabbarController) as? UITabBarController{
                    tabbarController.modalPresentationStyle = .fullScreen
                    vc.present(tabbarController, animated: true, completion: nil)
                }
            }
        }
    }
}
