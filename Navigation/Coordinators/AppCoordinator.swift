//
//  AppCoordinator.swift
//  Navigation
//
//
//

import UIKit

final class AppCoordinator: Coordinatable {

    private(set) var childCoordinators: [Coordinatable] = []
    
    private let factory: AppFactory
    
    init(factory: AppFactory) {
        self.factory = factory
    }
    
    func start() -> UIViewController {
        
        let feedCoordinator = FeedCoordinator(moduleType: .feed, factory: factory)
        let profileCoordinator = ProfilCoordinator(moduleType: .profile, factory: factory)
        
        let appTabBarController = AppTabBarController(viewControllers: [
            feedCoordinator.start(),
            profileCoordinator.start()
        ])
        
        addChildCoordinator(feedCoordinator)
        addChildCoordinator(profileCoordinator)
        
        return appTabBarController
    }
    
    func addChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator}) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 === coordinator }
    }
}
