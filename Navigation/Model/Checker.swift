//
//  Checker.swift
//  Navigation
//
//  сервис для проверки логина и пароля
//

import UIKit

// Singleton (Одиночка)
final class Checker {
    
    static let shared = Checker()
    
    private init() {}
    #if DEBUG
    private let login = "test"
    private let password = "123"
    #else
    private let login = "sainchuk"
    private let password = "123"
    #endif
    func check (login: String, password: String)->Bool {
        if login == self.login && password == self.password {
            return true
        }else {
            return false
        }
    }
}


// Delegate (Делегат)
protocol LoginViewControllerDelegate {
    func check(login: String, password: String)-> Bool
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        if Checker.shared.check(login: login, password: password) == true {
            return true
        }else {
            return false
        }
    }
}

// Factory (Фабрика для производства обьектов проверки пароля)
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
    
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
