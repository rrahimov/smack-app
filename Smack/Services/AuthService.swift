//
//  AuthService.swift
//  Smack
//
//  Created by Ruhullah Rahimov on 18.01.21.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    //variables to store in defaults (to stay even if the app is closed)
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        } set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String //as? ?? ""
        } set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        } set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            let result = response.result
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                // Standard practice
                //                if let json = response.value as? Dictionary<String, Any> {
                //                    if let email = json["user"] as? String {
                //                        self.userEmail = email
                //                    }
                //                    if let token = json["token"] as? String {
                //                        self.authToken = token
                //                    }
                //                }
                
                // Decoder
                if let data = response.data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let user = try decoder.decode(User.self, from: data)
                        if let token = user.token {
                            self.authToken = token
                        }
                    } catch (let error) {
                        print("parse error ", error.localizedDescription)
                    }
                } else {
                    print("no data found")
                    completion(false)
                }
                
                // Using SwiftyJSON
                //                guard let data = response.data else { return }
                //                let json = JSON(data: data)
                //                self.userEmail = json["user"].stringValue
                //                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            case .failure:
                completion(false)
                debugPrint(response as Any)
            }
        }
    }
    
    func createUser(avatarColor: String, avatarName: String, email: String, name: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-type": "application/json; charset=utf-8"
        ]
        
        AF.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            let result = response.result
            switch result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let user = try decoder.decode(User.self, from: data)
                        
                        UserDataService.instance.setUserData(id: user.id ?? "", avatarColor: user.avatarColor ?? "", avatarName: user.avatarName ?? "", email: user.email ?? "", name: user.name ?? "")
                        completion(true)
                        
                    } catch {
                        print("parse error")
                        completion(false)
                    }
                }
            case .failure:
                print("no data found")
                completion(false)
            }
        }
    }
    
}
