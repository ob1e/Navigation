//
//  PostViewController.swift
//  Navigation
//
//  Created by Саинчук Николай on 05.09.2022.
//

import UIKit


class PostViewController: UIViewController {
    
    // MARK: - Properties
    
    var dataSource = FeedViewController()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Post Title"
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .darkGray
        setupBarButtonItem()
        titleLabel.text = dataSource.dataSource.title 
        setupConstraints()
    }
    
    func setupBarButtonItem() {
        let barItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(addTarget))
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    deinit {
        
    }
    
    @objc func addTarget() {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
}

