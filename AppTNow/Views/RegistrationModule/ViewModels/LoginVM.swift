//
//  LoginVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 27/07/2023.
//

import SwiftUI
import MLBranchSSO

final class LoginVM: SocailVM {
    @Published var email = ""
    @Published var password = ""
    @Published var isSecureTextFeild = true
    @Published var moveToHome = false
    @Published var moveToAddPhoneNumber = false
}
extension LoginVM {
    
    func loginUser() async {
        validationCheck() ? await callLoginAPI(): nil
    }
    
    private func validationCheck() -> Bool {
        if password.isEmpty || email.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        if !Validator.shared.isValidEmail(email) {
            showError(message: "Email is not valid")
            return false
        }
        if !Validator.shared.isValidPassword(password) {
            showError(message: "Please enter right password")
            return false
        }
        return true
    }
}

extension LoginVM {
    @MainActor private func callLoginAPI(_ token: String? = nil) async {
        self.showLoader = true
        let request: AuthEndPoint = .login(email: email, password: password)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<User>.self)
        if handelUser(result: result) {
            moveToHome.toggle()
        }
    }
}
// MARK: - Social Login
extension LoginVM {
    func socialButtonAction(type: SSO) {
        Task{
            guard await getToken(with: type) else {return}
            guard UserManager.shared.isUserPhoneRegistered() else {
                moveToAddPhoneNumber.toggle()
                return
            }
            moveToHome.toggle()
        }
    }
}
