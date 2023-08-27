//
//  AppFactory.swift
//  Navigation
//
//  Фабрика для создания модулей
//

import UIKit

final class AppFactory {

    func makeModule(ofType moduleType: Module.Moduletype) -> Module {
        switch moduleType {
        case .feed:
            let viewModel = FeedViewModel()
            let view = UINavigationController(rootViewController: FeedViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .profile:
            let viewModel = ProfileViewModel()
            let view = UINavigationController(rootViewController: LogInViewController(viewModel: viewModel, loginDelegate: LoginInspector(), cheker: CheckerService(viewModel: viewModel)))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        }
    }

}


