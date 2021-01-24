//
//  Constants.swift
//  Smack
//
//  Created by Ruhullah Rahimov on 13.01.21.
//

import Foundation
import Alamofire

typealias CompletionHandler = (_ success: Bool) -> ()

//URL constants
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

//segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers

let HEADER: HTTPHeaders = [
    "Content-type": "application/json; charset=utf-8"
]
