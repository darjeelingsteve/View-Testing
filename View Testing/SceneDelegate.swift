//
//  SceneDelegate.swift
//  View Testing
//
//  Created by Stephen Anthony on 27/10/2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainSceneRootViewController()
        window?.makeKeyAndVisible()
    }
}
