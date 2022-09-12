//
//  FeedViewController.swift
//  Navigation
//
//  Created by Саинчук Николай on 05.09.2022.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: - Properties
    var dataSource = Post(title: "Post Title")
    
    private let  button: UIButton = {
        let button = UIButton()
        button.setTitle(" Post ", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    func setupUI() {
        addTargets()
        setupConstraints()
    }
    
    func addTargets() {
        button.addTarget(self, action: #selector(openPost), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func openPost() {
        let postViewController = PostViewController ()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

