//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Саинчук Николай on 05.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var profileHeaderView: ProfileHeaderView = ProfileHeaderView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        viewWillLayoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.frame
    }
}

