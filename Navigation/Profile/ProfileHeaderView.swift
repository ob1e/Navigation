//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Саинчук Николай on 15.09.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextViewDelegate {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Profile"
        title.textColor = .black
        return title
    }()
    
    let name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Sainchuk Nikolay"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return name
    }()
    
    let avatar: UIImageView = {
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
    
    let status: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Waiting for something..."
        view.textColor = .gray
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    let textField: UITextField = {
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
        return view
    }()
    
    var showStatus: UIButton = {
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
        return button
    }()
    
    private var statusText: String = ""
    
    // MARK: - Methods
    
    func addTarget() {
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    func addTargets() {
        showStatus.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        status.text = statusText
        print("\(status.text!)")
        endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = String(textField.text!)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
        addTargets()
        addTarget()
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
        self.addSubview(titleLabel)
        self.addSubview(name)
        self.addSubview(avatar)
        self.addSubview(status)
        self.addSubview(showStatus)
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 27),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            avatar.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            status.bottomAnchor.constraint(equalTo: showStatus.topAnchor, constant: -71),
            status.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            status.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            showStatus.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 61),
            showStatus.heightAnchor.constraint(equalToConstant: 50),
            showStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}







