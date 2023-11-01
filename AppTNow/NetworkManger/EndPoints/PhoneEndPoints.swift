//
//  ForgotPasswordRequests.swift
//  Cold Therapy swiftUI
//
//  Created by Taimoor Arif on 27/03/2023.
//

import Foundation

enum PhoneEndPoints {
    case generateOtp(email: String)
    case verifyOtp(email: String, code: String)
    case resetPassword(password: String)
    case updatePassword(oldPassword: String, newpassword: String)
    
}

extension PhoneEndPoints: Request {
    
    private var baseURL: String {
        return AppUrl.BASEURL
    }
    
    var url: URL {
        switch self {
        case .generateOtp:
            return URL(string: baseURL + "generate_otp").orEmpty
        case .verifyOtp:
            return URL(string: baseURL + "verify_otp").orEmpty
        case .resetPassword:
            return URL(string: baseURL + "reset_password").orEmpty
        case .updatePassword:
            return URL(string: baseURL + "update_password").orEmpty
        }
    }
    
    var methodType: HttpMethod {
        switch self {
        case .generateOtp(let email):
            return .post(
                [
                    "email": email
                ]
            )
        case .verifyOtp(let email, let code):
            return .post(
                [
                    "email": email,
                    "otp": code
                ]
            )
        case .resetPassword( let password):
            return .put(
                [
                    "user_id": "\(UserManager.shared.get()?.id ?? 0)",
                    "password": password]
            )
        case .updatePassword(let oldPassword, let password):
            return .put(
                [
                    "old_password": oldPassword,
                    "new_password": password,
                    "user_id": "\(UserManager.shared.get()?.id ?? 0)"
                ]
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(UserManager.shared.get()?.token ?? "")",
                "Content-Type": "application/json;charset=utf-8"]
    }
}

enum SettingEndPoints {
    case updateEmail(email:String)
    case updateNumber(newPhoneNumber: String)
    case updateProfile(image: String, name: String)
    case deleteAccount
    case saveBusiness
}
extension SettingEndPoints: Request {
    
    private var baseURL: String {
        return AppUrl.BASEURL
    }
    
    var url: URL {
        switch self {
        case .updateEmail:
            return URL(string: baseURL + "update_email").orEmpty
        case .updateNumber:
            return URL(string: baseURL + "update_phone_number").orEmpty
        case .updateProfile:
            return URL(string: baseURL +  "edit_profile_image").orEmpty
        case .deleteAccount:
            return URL(string: baseURL +  "account_delete").orEmpty
        case .saveBusiness:
            return URL(string: baseURL +  "get_saved_business").orEmpty
        }
    }
    
    var methodType: HttpMethod {
        switch self {
        case .updateEmail(let email):
            return .post(
                [
                    "user_id": "\(UserManager.shared.get()?.id ?? 0)",
                    "email": email
                ]
            )
        case .updateNumber(let newNumber ):
            return .put(
                [
                    "user_id": "\(UserManager.shared.get()?.id ?? 0)",
                    "number": newNumber
                ]
            )
        case .updateProfile(let image, let name ):
            return .post(
                [
                    "user_id": "\(UserManager.shared.get()?.id ?? 0)",
                    "image": image,
                    "name": name
                ]
            )
        case .deleteAccount:
            return .delete(
                [
                    "user_id": "\(UserManager.shared.get()?.id ?? 0)"
                ]
            )
        case .saveBusiness:
            return .get(
                [
                    URLQueryItem(
                        name: "user_id",
                        value: "\(UserManager.shared.get()?.id ?? 0)")
                ]
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(UserManager.shared.get()?.token ?? "")",
                "Content-Type": "application/json;charset=utf-8"]
    }
}
