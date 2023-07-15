//
//  NetworkService.swift
//  Navigation
//
//
//

import Foundation

struct NetworkService {
    static func request (for configuration: AppConfiguration){
        
        var urlAdress = URL(string: "")
        
        switch configuration{
        case .first(let url):
            urlAdress = URL(string: url)
        case .second(let url):
            urlAdress = URL(string: url)
        case .third(let url):
            urlAdress = URL(string: url)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlAdress!) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error response")
                return
            }
            
            if !((200..<300).contains(httpResponse.statusCode)) {
                print("Error, status code = \(httpResponse.statusCode)")
                return
            }
            
            guard let data else {
                return
            }
            
            do {
                if let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                    print("data = \(answer)")
                }else {
                    print("Error parsing data")
                }

            } catch {
                print(error)
            }

            print("statusCode = \(httpResponse.statusCode)")
            print("allHeaderFields = \(httpResponse.allHeaderFields)")
        }
        
        task.resume()
    }
    
}


enum AppConfiguration {
    case first (String)
    case second (String)
    case third (String)
}


