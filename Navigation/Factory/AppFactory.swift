//
//  AppFactory.swift
//  Navigation
//
//  Фабрика для создания модулей
//

import UIKit

final class AppFactory {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func makeModule(ofType moduleType: Module.Moduletype) -> Module {
        switch moduleType {
        case .feed:
            let viewModel = FeedViewModel()
            let view = UINavigationController(rootViewController: FeedViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .profile:
            let viewModel = ProfileViewModel(userService: userService)
            let view = UINavigationController(rootViewController: LogInViewController(viewModel: viewModel, loginDelegate: LoginInspector()))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        }
    }
    
}


