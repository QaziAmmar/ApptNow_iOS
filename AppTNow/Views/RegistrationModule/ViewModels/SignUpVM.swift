//
//  SignUpVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

final class SignUpVM: SocailVM {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var newPassword = ""
    @Published var isPasswordTextFeild = true
    @Published var isNewPasswordSecure = true
    @Published var moveToAddPhoneNumber = false
    @Published var showPasswordPopUp = false

}
extension SignUpVM {
    
    func signUpUser() async {
        validationCheck() ? await callSignUpAPI(): nil
    }
    
    private func validationCheck() -> Bool {
        guard  !name.isEmpty, !email.isEmpty, !password.isEmpty, !newPassword.isEmpty else {
            showError(message: "Please fill all the fields.")
            return false
        }
        
        guard Validator.shared.isValidEmail(email) else {
            showError(message: "Email is not valid.")
            return false
        }
        
        guard Validator.shared.isValidPassword(password) else {
            showError(message: "Please Enter the right password")
            return false
        }
                
        guard password == newPassword else {
            showError(message: "Passwords do not match.")
            return false
        }
        return true
    }

}
extension SignUpVM  {
    
    @MainActor private func callSignUpAPI() async {
        self.showLoader = true
        let request : AuthEndPoint = .signUp(name: name, email: email, password: password, confirmPassword: newPassword)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<User>.self)
        self.showLoader = false
        if  handelUser(result: result) {
            moveToAddPhoneNumber.toggle()
        }
    }
}
