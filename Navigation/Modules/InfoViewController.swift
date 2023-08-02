//
//  InfoViewController.swift
//  Navigation
//
//  Created by Саинчук Николай on 05.09.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test text"
        label.numberOfLines = 0
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    lazy var orbitalLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test text"
        label.numberOfLines = 0
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    let alertController = UIAlertController(title: "Title", message: "Massage", preferredStyle: .alert)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshTitle()
    }

    // MARK: - Methods
    func refreshTitle() {
        NetworkService.requestUser { textTitle in
            DispatchQueue.main.async {
                self.titleLabel.text = textTitle
            }
        }
        NetworkService.requestPlanet { textTitle in
            DispatchQueue.main.async {
                self.orbitalLabel.text = textTitle
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .brown
        setupAlertConfiguration()
        setupConstraints()
        addTargets()
    }
    
    func setupConstraints() {
        view.addSubview(button)
        view.addSubview(titleLabel)
        view.addSubview(orbitalLabel)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            orbitalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            orbitalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orbitalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            orbitalLabel.heightAnchor.constraint(equalToConstant: 50),
       
        ])
    }
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in print("Push button OK")}))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            print("Push button Cancel")
        }))
    }
    
    func addTargets() {
        button.addTarget(self, action: #selector(addTarget), for: .touchUpInside)
    }
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
    }
}


