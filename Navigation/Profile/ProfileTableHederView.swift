//
//  ProfileHeaderView.swift
//  Navigation


import UIKit

class ProfileTableHederView: UITableViewHeaderFooterView {
    
    // MARK: - Properties

    lazy var fullNameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return name
    }()
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.layer.borderWidth = 3
        image.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.layer.shouldRasterize = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let statusLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "multiply.square.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 25), forImageIn: .normal)
        button.tintColor = UIColor(named: "redPepper")
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        return button
    }()
    
    lazy var transparentBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    
    var beginPointAvatar = CGPoint()  // начальная точка аватарки
    private var statusText: String = ""
    
    // MARK: Life cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupConstraint()
        setupAnimation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc func buttonPressed() {
        statusLabel.text = statusText
        print("\(statusLabel.text!)")
        endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = String(textField.text!)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    private func setupAnimation() {
        let tapAvatar = UITapGestureRecognizer(
            target: self, action: #selector(didTapAvatar)
        )
        self.avatarImageView.addGestureRecognizer(tapAvatar)
    }
    
    @objc private func didTapAvatar() {
        basicAnimation()
    }
    
    private func basicAnimation() {
        beginPointAvatar = self.avatarImageView.center
        UIView.animate(withDuration: 0.5){
            let scale = UIScreen.main.bounds.width / self.avatarImageView.bounds.width
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - self.beginPointAvatar.y)
            self.avatarImageView.layer.cornerRadius = .zero
            self.avatarImageView.layer.borderWidth = .zero
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.transparentBackground.isHidden = false
            self.transparentBackground.layer.opacity = 0.5
            self.avatarImageView.isUserInteractionEnabled = false
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.buttonClose.alpha = 1.0
            }
        }
    }

    @objc func closePressed() {
        UIView.animate(withDuration: 0.5) {
            self.avatarImageView.transform = .identity
            self.avatarImageView.center = self.beginPointAvatar
            self.avatarImageView.layer.cornerRadius = 50
            self.avatarImageView.layer.borderWidth = 3
            self.avatarImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
            self.avatarImageView.isUserInteractionEnabled = true
            self.buttonClose.alpha = 0.0
            self.transparentBackground.isHidden = true
            self.transparentBackground.layer.opacity = 0.0
        }
    }
    
    func setupConstraint() {
        self.addSubview(setStatusButton)
        self.addSubview(statusTextField)
        self.addSubview(transparentBackground)
        self.addSubview(fullNameLabel)
        self.addSubview(statusLabel)
        self.addSubview(avatarImageView)
        self.addSubview(buttonClose)

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
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            buttonClose.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            buttonClose.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            transparentBackground.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            transparentBackground.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}







