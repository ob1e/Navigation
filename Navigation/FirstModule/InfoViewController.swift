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
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let alertController = UIAlertController(title: "Title", message: "Massage", preferredStyle: .alert)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Methods
    
    func setupUI() {
        view.backgroundColor = .brown
        setupAlertConfiguration()
        setupConstraints()
        addTargets()
    }
    
    func setupConstraints() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150)
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


