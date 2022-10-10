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

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Post", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(openPost), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonTwo: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("Post", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(openPost), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    func setupUI() {
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(buttonOne)
        stackView.addArrangedSubview(buttonTwo)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonOne.heightAnchor.constraint(equalToConstant: 50),
            buttonOne.widthAnchor.constraint(equalToConstant: 100),
            
            buttonTwo.heightAnchor.constraint(equalToConstant: 50),
            buttonTwo.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func openPost() {
        let postViewController = PostViewController ()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

