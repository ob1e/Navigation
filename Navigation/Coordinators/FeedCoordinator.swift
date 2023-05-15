//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by JaY on 26.04.2023.
//

import UIKit

final class FeedCoordinator: ModuleCoordinatable {
    var childCoordinators: [Coordinatable] = []
    
    let moduleType: Module.Moduletype
    
    private let factory: AppFactory
    
    var module: Module?
    
    
    init(moduleType: Module.Moduletype, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? FeedViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    func pushPostViewController() {
        let viewControllerToPush = PostViewController()
        (module?.view as? UINavigationController)?.pushViewController(viewControllerToPush, animated: true)
    }
    
}
