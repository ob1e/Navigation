//
//  Coordinatable.swift
//  Navigation
//
//  Flow Coordinator
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] {get}
    func start() -> UIViewController
    func addChildCoordinator(_ coordinator: Coordinatable)
    func removeChildCoordinator(_ coordinator: Coordinatable)
}

protocol ModuleCoordinatable: Coordinatable {
    var module: Module? {get}
    var moduleType: Module.Moduletype {get}
}

extension Coordinatable {
    func addChildCoordinator(_ coordinator: Coordinatable) {}
    func removeChildCoordinator(_ coordinator: Coordinatable) {}
}
