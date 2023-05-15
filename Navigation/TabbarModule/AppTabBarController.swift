//
//  AppTabBarController.swift
//  Navigation
//
//
//

import UIKit

class AppTabBarController: UITabBarController {
    
    init(viewControllers: [UIViewController]){
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("oops")
    }
}

