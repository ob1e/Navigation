//
//  User.swift
//  Информация о пользователе
//

import UIKit

// Информация о пользователе
class User {
    var login: String
    var fullName: String
    var avatar: UIImage?
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

protocol UserService {
    
    func userService(login: String)->User?
}

    // текущий пользователь
class CurrentUserService: UserService {
    
    var user = User(login: "sainchuk", fullName: "Саинчук Николай", avatar: UIImage(named: "avatar")!, status: "Listens to music")

    func userService(login: String) -> User? {
        if login == user.login {
            return user
        }
        return nil
    }
}

    // тестовый пользователь
class TestUserService: UserService {

    var testUser = User(login: "test", fullName: "Test User", avatar: UIImage(named: "photo")!, status: "Testing status")
    
    func userService(login: String) -> User? {
        if login == testUser.login {
            return testUser
        }
        return nil
    }
    
}


