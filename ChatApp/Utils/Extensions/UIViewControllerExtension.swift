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
        static func HomeTabbarController(vc: UIViewController){
            if let tabbarController = Constants.Storyboards.Home.instantiateViewController(withIdentifier: Constants.String.TabbarController.HomeTabbarController) as? UITabBarController{
                tabbarController.modalPresentationStyle = .fullScreen
                vc.present(tabbarController, animated: true, completion: nil)
            }
        }

        static func LoginViewController(vc: UIViewController){
            let viewController = Constants.Storyboards.Main.instantiateViewController(withIdentifier: Constants.String.ViewController.LoginViewController)
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            vc.present(navigationController, animated: true, completion: nil)
        }
    }
}
