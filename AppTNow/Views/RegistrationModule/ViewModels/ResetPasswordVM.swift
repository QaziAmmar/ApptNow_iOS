//
//  ResetPasswordVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

final class ResetPasswordVM: ObservableObject {
    @Published var password = ""
    @Published var newPassword = ""
    @Published var showError = false
    @Published var isPasswordTextFeild = true
    @Published var isNewPasswordSecure = true
    @Published var showLoader = false
    
    var errorMessage = ""
    
}
extension ResetPasswordVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func changePassword() async {
        validationCheck() ? await resetPassword() : nil
    }
    
    private func validationCheck() -> Bool {
        guard !password.isEmpty, !newPassword.isEmpty else {
            showError(message: "Please fill all the fields.")
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
extension ResetPasswordVM : RequestManager {
    
    @MainActor func resetPassword() async {
        self.showLoader = true
        let request : PhoneEndPoints = .resetPassword(password: password)
        
        let result = await sendApiRequest(request: request, responseModel: GenericResponse.self)
        self.showLoader = false
        switch result {
            
        case .success(let data):
            debugPrint(data.message ?? "")
            
        case .failure(let error):
            debugPrint(error.customMessage)
            self.showError(message: error.customMessage)
        }
    }
}
