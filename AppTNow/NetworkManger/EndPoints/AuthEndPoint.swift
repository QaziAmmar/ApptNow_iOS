//
//  SignUpEndPoints.swift
//  Cold Therapy swiftUI
//
//  Created by Taimoor Arif on 15/03/2023.
//

import Foundation

enum AuthEndPoint {
    case signUp(name: String, email: String, password: String, confirmPassword: String)
    case login(email: String, password: String)
    case socialLogin(socialKey: String, socialToken: String)
}

extension AuthEndPoint: Request {
    
    var url: URL {
        switch self {
        case .signUp:
            return URL(string: AppUrl.BASEURL + "register").orEmpty
        case .login:
            return URL(string: AppUrl.BASEURL + "login").orEmpty
        case .socialLogin:
            return URL(string: AppUrl.BASEURL + "social_login").orEmpty
        }
    }
    
    var methodType: HttpMethod {
        switch self {
            
        case .signUp(let name, let email, let password, let confirmPassword):
            
            let params = ["name": name,
                          "email": email,
                          "password": password,
                          "confirm_password": confirmPassword]
            return .post(params)
            
        case .login(email: let email, password: let password):
            
            let params = ["email": email,
                          "password": password]
            return .post(params)
            
        case .socialLogin(let socialKey, let socialToken):
            
            let params = ["social_key": socialKey,
                          "social_token": socialToken]
            return .post(params)
        }
    }
    
}

extension Optional where Wrapped == URL {
    var orEmpty: URL {
        return self ?? URL(string: "")!
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orEmpty: Int {
        return self ?? 0
    }
}
