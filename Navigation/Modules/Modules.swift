//
//  Modules.swift
//  Navigation
//
//
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    enum Moduletype {
        case feed
        case profile
    }
    
    let moduleType: Moduletype
    let viewModel: ViewModelProtocol
    let view: UIViewController
}

extension Module.Moduletype {
    var tabBarItem: UITabBarItem {
        switch self {
        case .feed:
            return UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        case.profile:
            return UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        }
    }
}


