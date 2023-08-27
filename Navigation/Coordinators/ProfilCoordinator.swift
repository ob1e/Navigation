//
//  ProfilCoordinator.swift
//  Navigation
//
//
//

import UIKit

final class ProfilCoordinator: ModuleCoordinatable {
    var moduleType: Module.Moduletype
    
    private let factory: AppFactory
    
    var childCoordinators: [Coordinatable] = []
    var module: Module?
    var loginDelegate: LoginViewControllerDelegate?
    
    
    init(moduleType: Module.Moduletype, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: moduleType)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? ProfileViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
    
    
    func pushProfileViewController() {
        let viewControllerToPush = ProfileViewController()
        (module?.view as? UINavigationController)?.setViewControllers([viewControllerToPush], animated: true)
        
        
    }
    
}
    
