//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Саинчук Николай on 03.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    

// MARK: 1
    
    var firstTabNavigationController : UINavigationController!
    var secondTabNavigationController: UINavigationController!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let factory = AppFactory(userService: CurrentUserService())
        let appCoordinator = AppCoordinator(factory: factory)
        
        self.appCoordinator = appCoordinator
        
            /* Запуск сетевого запроса
        let appConfiguration: AppConfiguration = .first("https://swapi.dev/api/people/8")
       
        NetworkService.request(for: appConfiguration)
  */
        UITabBar.appearance().tintColor = UIColor(red: 95/255.0, green: 132/255.0, blue: 200/255.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .systemGray6
        
        self.window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
    }
    

    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
     
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
  
    }


}

