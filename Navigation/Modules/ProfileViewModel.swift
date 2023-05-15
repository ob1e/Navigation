//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by JaY on 29.04.2023.
//

import Foundation

protocol ProfileViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((ProfileViewModel.State)-> Void)? { get set }
    func updateState(viewInput: ProfileViewModel.ViewInput, user: User)
}

final class ProfileViewModel: ProfileViewModelProtocol {
 
  
    enum State {
        case initial
        case loading
    }
    enum ViewInput {
        case loginButtonDidTap
    }
    
    weak var coordinator: ProfilCoordinator?
    
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    private let userService: UserService
    init(userService: UserService) {
        self.userService = userService
    }
    
    func updateState(viewInput: ViewInput, user: User) {
        switch viewInput {
        case .loginButtonDidTap:
            state = .loading
            coordinator?.pushProfileViewController(user: user)
            
        }
    }
}
