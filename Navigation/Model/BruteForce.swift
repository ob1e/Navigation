//
//  File.swift
//  Navigation
//
//  Created by JaY on 31.05.2023.
//

import Foundation

class BruteForce {
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
    
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        return str
    }
    




    var password: String = ""
    

    func startBruteForce(passwordTo: String)-> String {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        
        while password != passwordTo {
            
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
        print(password)
        return password
    }
    
    func generatePassword(_ passwordLength: Int) -> String {
       
        let randomPassword : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
        let randomPasswordLength = UInt32(randomPassword.length)
        
            var returnValue = ""
        
        for _ in 0 ..< passwordLength {
            let randomPosition = arc4random_uniform(randomPasswordLength)
            var character = randomPassword.character(at: Int(randomPosition))
            returnValue += NSString(characters: &character, length: 1) as String
            }
        return returnValue
    }


}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
