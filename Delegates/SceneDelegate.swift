//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//

import UIKit

let mySceneDelegate : SceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setHomeRootController()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func setHomeRootController() {
        
        let root = CharactersListViewController()
        let NCProvider = HomeNC(rootViewController: root)
        
        window?.rootViewController = NCProvider
        window?.makeKeyAndVisible()
    }
    
}

