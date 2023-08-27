//
//  CheckerService.swift
//  Navigation
//
//


import Foundation
import FirebaseAuth
import UIKit


protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, loginVC: UIViewController)
    
}

class CheckerService: CheckerServiceProtocol {

    var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func checkCredentials(login: String, password: String, loginVC: UIViewController) {
 
        func showAlert(title: String, message: String, in vc: UIViewController) {
            let alertError = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "OK", style:  .default))
            
            vc.present(alertError, animated: true)
            
        }
        
        guard login != "" && password != "" else{
            showAlert(title: "Ошибка", message: "Не введен логин и пароль", in: loginVC)
            
            print("Пусто")
            return
        }
        
        Auth.auth().signIn(withEmail: login, password: password) { authDataResult, error in
            if let error {
                Auth.auth().createUser(withEmail: login, password: password) { authDataResult, error in
                    if let error  = error {
                        print(error.localizedDescription)
                        let err = error as NSError
                        switch err.code {
                        case AuthErrorCode.emailAlreadyInUse.rawValue:
                            showAlert(title: "Ошибка", message: "Этот email адрес уже используется", in: loginVC)
                            print("Этот email адрес уже используется")
                        case AuthErrorCode.invalidEmail.rawValue:
                            showAlert(title: "Ошибка", message: "Не верный формат email", in: loginVC)
                            print("Не верный формат email")
                        case AuthErrorCode.weakPassword.rawValue:
                            showAlert(title: "Ошибка", message: "Пароль слишком короткий", in: loginVC)
                            print("Пароль слишком короткий")
                        default:
                            print("Не известная ошибка")
                        }
                    }else {
                        
                        
                        
                    }
                    showAlert(title: "Успех", message: "Регистрация успешна", in: loginVC)
                    print("успешная регистрация")
                }
                print(error.localizedDescription)
            }else {
                if authDataResult?.user != nil {
                    self.viewModel.updateState(viewInput: .loginButtonDidTap)
                }
                
                print("Logined")
            }
        }
        
    }
    
}
