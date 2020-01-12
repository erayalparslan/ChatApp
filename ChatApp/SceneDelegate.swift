//
//  SceneDelegate.swift
//  jkt
//
//  Created by MacbookPro on 28.12.2019.
//  Copyright © 2019 Eray Alparslan. All rights reserved.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var authListener: AuthStateDidChangeListenerHandle?
    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        
        authListener = Auth.auth().addStateDidChangeListener({ (auth, user) in
            Auth.auth().removeStateDidChangeListener(self.authListener!)
            
            if user != nil{
                if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil{
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID:FUser.currentId()])
                    
                    DispatchQueue.main.async {
                        if let tabbarController = Constants.Storyboards.Home.instantiateViewController(withIdentifier: Constants.String.TabbarController.HomeTabbarController) as? UITabBarController{
                            tabbarController.modalPresentationStyle = .fullScreen
                            guard let windowScene = (scene as? UIWindowScene) else { return }
                            self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
                            self.window?.windowScene = windowScene
                            self.window?.rootViewController = tabbarController
                            self.window?.makeKeyAndVisible()
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window = self.window
                        }
                    }
                }
            }
        })
    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

