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
    
    
    let changeTitle: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Title", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    func setupUI() {
        view.backgroundColor = .lightGray
        self.navigationItem.title = "Profile"
        viewWillLayoutSubviews()
        setupConstraint()
    }
    
    override func viewWillLayoutSubviews() {

    }

    func setupConstraint() {
        view.addSubview(profileHeaderView)
        view.addSubview(changeTitle)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            changeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            changeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            changeTitle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            changeTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

