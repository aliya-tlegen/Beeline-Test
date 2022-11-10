//
//  SceneDelegate.swift
//  Beeline Test
//
//  Created by Алия Тлеген on 09.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewModel = MainPageViewModel(service: NetworkProvider())
        let viewController = MainPageViewController(mainPageViewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navController
        
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
}

