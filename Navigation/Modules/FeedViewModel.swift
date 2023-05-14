//
//  FeedViewModel.swift
//  Navigation
//
//
//

import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((FeedViewModel.State)-> Void)? { get set }
    func updateState(viewInput: FeedViewModel.ViewInput)
}

final class FeedViewModel: FeedViewModelProtocol {
    enum State {
        case initial
        case openPost
        case checkLableShow(CheckInfo)
    }
    
    enum ViewInput {
        case initial
        case postButtonDidTap
        case checkButtonDidTap(toShowCheck: Bool)
    }
    
    struct CheckInfo {
        let labelText: String
       
    }
    
    weak var coordinator: FeedCoordinator?
    var onStateDidChange: ((State) -> Void)?
    
    private(set) var state: State = .checkLableShow(CheckInfo.makeLabel(isHidden: true)) {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .postButtonDidTap:
            coordinator?.pushPostViewController()
            print("postOpen")
        case .initial:
            print("initial")
        case let .checkButtonDidTap(toShowCheck):
            state = .checkLableShow(CheckInfo.makeLabel(isHidden: !toShowCheck))
            
        }
    }
}

extension FeedViewModel.CheckInfo {
    static var showTextTrue: String { "Пароль введен верно"}
    static var showTextFalse: String { "Пароль введен не верно"}
}

private extension FeedViewModel.CheckInfo {
    static func makeLabel(isHidden: Bool) -> Self {
        let labelText: String = isHidden ? Self.showTextFalse : Self.showTextTrue
//        let info: String = isHidden ? "" : ""
        return FeedViewModel.CheckInfo(labelText: labelText)
    }
}
