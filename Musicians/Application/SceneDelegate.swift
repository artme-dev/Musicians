//
//  SceneDelegate.swift
//  Musicians
//
//  Created by Артём on 23.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
