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
        
        
        //    MARK: 2
//            let tabBarController = TabBarController()
//            let feedViewController = FeedViewController()
//        let loginViewController = LogInViewController()
//            loginViewController.loginDelegate = LoginInspector()
//        let factory = MyLoginFactory()
//            let factoryDelegate = MyLoginFactory().makeLoginInspector()
//            loginViewController.loginDelegate = factoryDelegate
        
            
        //    MARK: 3
//            firstTabNavigationController = UINavigationController.init(rootViewController: feedViewController)
//            secondTabNavigationController = UINavigationController.init(rootViewController: loginViewController)
            
        //    MARK: 4
            
//            tabBarController.viewControllers = [firstTabNavigationController, secondTabNavigationController]
            
        //    MARK: 5
            
//            let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
//            let item2 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
            
        //    MARK: 6
//            firstTabNavigationController.tabBarItem = item1
//            secondTabNavigationController.tabBarItem = item2
            
        //    MARK: 7
        UITabBar.appearance().tintColor = UIColor(red: 95/255.0, green: 132/255.0, blue: 200/255.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .systemGray6
        
        //    MARK: 8
//            let window = UIWindow(windowScene: windowScene)

//            window.rootViewController = tabBarController
//            window.makeKeyAndVisible()
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

