//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Саинчук Николай on 15.09.2022.
//

import UIKit

class ProfileTableHederView: UITableViewHeaderFooterView {
    
    // MARK: - Properties

    let fullNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Sainchuk Nikolay"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return name
    }()
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "photo")
        image.layer.borderWidth = 3
        image.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.layer.shouldRasterize = true
        return image
    }()
    
    let statusLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Waiting for something..."
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
   lazy var statusTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.layer.borderWidth = 1
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.clipsToBounds = true
        view.placeholder = "Input your text"
        view.textAlignment = .left
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.textColor = .black
        view.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return view
    }()
    
    lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    

    private var statusText: String = ""
    
    // MARK: - Methods

    @objc func buttonPressed() {
        statusLabel.text = statusText
        print("\(statusLabel.text!)")
        endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = String(textField.text!)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupConstraint()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func setupConstraint() {
        self.addSubview(fullNameLabel)
        self.addSubview(avatarImageView)
        self.addSubview(statusLabel)
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
//        
        NSLayoutConstraint.activate([
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),

            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),

            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -71),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),

            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 15),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),

            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 50),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}







