//
//  FeedModel.swift
//  Navigation
//
//
//

import UIKit

class FeedModel {
    
    public var secretWord = "secret"
    
    func check(word: String)->Bool {
        if word == secretWord {
            return true
        }else {
            return false
        }
    }
}
