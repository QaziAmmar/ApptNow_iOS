//
//  Validator.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 27/07/2023.
//

import UIKit

enum ValidationError: Error {
    case invalidPassword(description: String)
}

final class Validator {
    static let shared = Validator()
    
    private init() {}
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidURL(_ urlString: String?) -> Bool {
        if let urlString = urlString, let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func isImageEmpty(_ image: UIImage) -> Bool {
        return image.cgImage == nil && image.ciImage == nil
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{10}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        return phoneNumberPredicate.evaluate(with: phoneNumber)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // Password length should be 8 characters or more
        guard password.count >= 8 else {
            return false
        }
        
        // Password should contain at least one number
        let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        
        // Password should contain at least one special character
        let specialCharacters = CharacterSet(charactersIn: "!@#$%^&*()_-+=<>?/;:[]{},.")
        let hasSpecialChar = password.rangeOfCharacter(from: specialCharacters) != nil
        return hasNumber && hasSpecialChar
    }
}
