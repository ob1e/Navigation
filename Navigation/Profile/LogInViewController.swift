//
//  LogInViewController.swift
//  Navigation


import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Properties
    
    
    var loginDelegate: LoginViewControllerDelegate?
    private let viewModel: ProfileViewModelProtocol
//    var coordinator: ProfilCoordinator
    
    init(viewModel:  ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Scroll
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    //  Stack
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    // Logo
    var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "logo")
        logo.clipsToBounds = true
        logo.layer.shouldRasterize = true
        return logo
    }()
    //    Username
     lazy var loginTextField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.tag = 0
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.backgroundColor = .systemGray6
        login.borderStyle = .roundedRect
        login.layer.borderWidth = 0.5
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        login.placeholder = "Email or phone"
        login.autocapitalizationType = .none
        login.clearButtonMode = .whileEditing
        login.clipsToBounds = true
        login.layer.cornerRadius = 10
        login.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        login.delegate = self
        login.tintColor = UIColor(named: "AccentColor")
        login.text = "sainchuk"
        return login
    }()
    //    Password
     lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.tag = 1
        password.backgroundColor = .systemGray6
        password.borderStyle = .roundedRect
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.placeholder = "Password"
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.clipsToBounds = true
        password.layer.cornerRadius = 10
        password.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        password.delegate = self
        password.tintColor = UIColor(named: "AccentColor")
        password.text = "123"
        return password
    }()
    // Button
    private lazy var button: CustomButton = {
        let button = CustomButton(title: "Log in")
        button.buttonTapped = {
            button.addTarget(self, action: #selector(self.logInProfile), for: .touchUpInside)
        }
        return button
    }()
    
 
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    func setupUI(){
        self.view.backgroundColor = .white
        setupConstraint()
        setupGestures()
    }
    
    func setupConstraint() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(logoImage)
        scrollView.addSubview(button)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        
        NSLayoutConstraint .activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            button.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16)
        ])
    }
    // Скрытие клавиатуры
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.button.frame.origin.y + self.button.frame.height
            
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
//    проверка ввода логина
//    @objc private func loginInProfile() {
////        coordinator.pushProfileViewController()
//        print("Log In")
//    }
    
//    func errorAlert() {
//        let alert = UIAlertController(title: "Ошибка", message: "Введен не верный логин или пароль", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
//        present(alert, animated: true)
//    }
    @objc private func logInProfile() {
        #if DEBUG
        let service = TestUserService()
        #else
        let service = CurrentUserService()
        #endif
        
//        if let user = service.userService(login: loginTextField.text ?? "") {
//            let profileVC = ProfileViewController(user: user)
//            navigationController?.setViewControllers([profileVC], animated: true)
//        }else   {
//            let alertController = UIAlertController(title: "Ошибка", message: "Введен не верный логин или пароль", preferredStyle: .alert)
//                        alertController.addAction(UIAlertAction(title: "OK", style: .destructive))
//                        present(alertController,animated: true)
//        }

        if loginDelegate?.check(login: loginTextField.text ?? "", password: passwordTextField.text ?? "") == true {
         
            guard let user = service.userService(login: loginTextField.text ?? "")else {return print("opps")}
//            let profileVC = ProfileViewController(user: user )
            viewModel.updateState(viewInput: .loginButtonDidTap, user: user)
//            navigationController?.setViewControllers([profileVC], animated: true)
            
        }else   {
            let alertController = UIAlertController(title: "Ошибка", message: "Введен не верный логин или пароль", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .destructive))
                        present(alertController,animated: true)
        }
    }
}





extension LogInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.forcedHidingKeyboard()
        return true
    }
}

extension LogInViewController: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        print("login is correct")
        return true
    }
}


