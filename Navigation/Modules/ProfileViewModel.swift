//
//  ProfileViewModel.swift
//  Navigation
//
//
//

import Foundation

protocol ProfileViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((ProfileViewModel.State)-> Void)? { get set }
    func updateState(viewInput: ProfileViewModel.ViewInput)
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
    
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .loginButtonDidTap:
            state = .loading
            coordinator?.pushProfileViewController()
            
        }
    }
}
