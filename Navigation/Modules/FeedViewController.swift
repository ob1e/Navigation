//
//  FeedViewController.swift
//  Navigation
//
//  Created by Саинчук Николай on 05.09.2022.
//

import UIKit


class FeedViewController: UIViewController {

    // MARK: - Properties
//   var dataSource = Post(title: "Title post")
//
//    var posts: [Post] = []
    
    private let viewModel: FeedViewModelProtocol?
    weak var coordinator: FeedCoordinator?
    
//    private var toShowCheck: Bool {
//        guard let title = checkGuessButton.titleLabel?.text else {
//            return true
//        }
//        switch title {
//        case FeedViewModel.CheckInfo.showTextFalse:
//            return false
//        case FeedViewModel.CheckInfo.showTextTrue:
//            return true
//        default:
//            return true
//        }
//    }
   
    
    private lazy var  scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // Лейбл верно не верно введенного пароля
    private lazy  var chekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.isHidden = true
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var password: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.white.cgColor
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.delegate = self
        textField.placeholder = "Enter password"
        textField.text = "secret"
        textField.tag = 0
        return textField
    }()
    
    private lazy var buttonOne: CustomButton = {
        let button = CustomButton(title: "Post 1")
        button.buttonTapped = {
            button.addTarget(self, action: #selector(self.openPost), for: .touchUpInside)
        }
        
        return button
        
    }()
    
    private lazy var buttonTwo: CustomButton = {
        let button = CustomButton(title: "Post 2")
        button.buttonTapped = {
            button.addTarget(self, action: #selector(self.openPost), for: .touchUpInside)
        }
        return button
        
    }()
    
// Кнопка проверки введенного текста
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Chek Password")
        let feedModel = FeedModel()
//        button.addTarget(self, action: #selector(self.didTapCheck), for: .touchUpInside)
        button.buttonTapped = {
            guard let text = self.password.text else {return}
            if feedModel.check(word: text) == true {
                self.chekLabel.isHidden = false
                self.chekLabel.textColor = .systemGreen
                self.chekLabel.text = "Пароль верный"
                print("true")
            }else {
                self.chekLabel.isHidden = false
                self.chekLabel.textColor = .systemRed
                self.chekLabel.text = "Пароль не верный"
                print("false")
            }
        }

        return button
    }()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
 //  Инициализатор viewModel
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func setupUI() {
        setupConstraints()
        setupGestures()
        bindViewModel()
    }

    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(chekLabel)
        scrollView.addSubview(stackView)
        
        scrollView.addSubview(checkGuessButton)
        
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(buttonOne)
        stackView.addArrangedSubview(buttonTwo)
//        stackView.addArrangedSubview(checkGuessButton)
        
       
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 400),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 16),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            
//            stackView.heightAnchor.constraint(equalToConstant: 200),
            
            password.heightAnchor.constraint(equalToConstant: 50),
            password.widthAnchor.constraint(equalToConstant: 200),
            
            buttonOne.heightAnchor.constraint(equalToConstant: 50),
            buttonOne.widthAnchor.constraint(equalToConstant: 200),
            
            buttonTwo.heightAnchor.constraint(equalToConstant: 50),
            buttonTwo.widthAnchor.constraint(equalToConstant: 200),
            
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 200),
            checkGuessButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            chekLabel.heightAnchor.constraint(equalToConstant: 50),
            chekLabel.widthAnchor.constraint(equalToConstant: 200),
//            chekLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 100),
            chekLabel.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -16),
//            chekLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            chekLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func openPost() {
//        viewModel.updateState(viewInput: .postButtonDidTap)
        viewModel?.updateState(viewInput: .postButtonDidTap)
        self.chekLabel.isHidden = true
        
    }

//    @objc func didTapCheck() {
//        viewModel?.updateState(viewInput: .checkButtonDidTap(toShowCheck: toShowCheck))
//    }
    
//    @objc func openPost() {
//        let postViewController = PostViewController ()
//        navigationController?.pushViewController(postViewController, animated: true)
//        chekLabel.isHidden = true
//    }
    
    //Hidin Keyboard
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

    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
//            let buttonPointY = self.stackView.frame.origin.y + self.checkGuessButton.frame.origin.y + self.checkGuessButton.frame.height
            let buttonPointY = self.checkGuessButton.frame.origin.y + self.checkGuessButton.frame.height
            
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < buttonPointY
            ? buttonPointY - keyboardOriginY + 16
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
    
    func bindViewModel() {
        viewModel?.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case  .openPost:
                self.chekLabel.isHidden = true
                print("Open post")
            case .checkLableShow:
                self.chekLabel.isHidden = false
                print("lable show")
            case .initial:
                print("initial")
            }
        }
    }
}

extension FeedViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.forcedHidingKeyboard()
        return true
    }
}

