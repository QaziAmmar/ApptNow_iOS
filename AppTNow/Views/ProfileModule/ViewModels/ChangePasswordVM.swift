//
//  ChangePasswordVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 06/08/2023.
//

import Foundation

final class ChangePasswordVM: APPTNowBaseViewModel {
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var newConfirmPassword = ""
    @Published var isOldPasswordTextFeild = true
    @Published var isNewPasswordSecure = true
    @Published var isNewConfrimPasswordSecure = true
    
}
extension ChangePasswordVM {
  
    func changePassword() async {
        validationCheck() ? await changePasswordApi() : nil
    }
    
    private func validationCheck() -> Bool {
        guard !oldPassword.isEmpty, !newPassword.isEmpty, !newConfirmPassword.isEmpty else {
            showError(message: "Please fill all the fields.")
            return false
        }
        
        guard Validator.shared.isValidPassword(oldPassword) else {
            showError(message: "Please Enter the right old password")
            return false
        }
        
        guard Validator.shared.isValidPassword(newPassword) else {
            showError(message: "Please Enter the right password")
            return false
        }
        
        guard newPassword == newConfirmPassword else {
            showError(message: "Passwords do not match.")
            return false
        }
        return true
    }
}
extension ChangePasswordVM : RequestManager {
    
    @MainActor func changePasswordApi() async {
        self.showLoader = true
        let request : PhoneEndPoints = .updatePassword(oldPassword: oldPassword, newpassword: newPassword)
        let result = await sendApiRequest(request: request, responseModel: GenericResponse.self)
        self.showLoader = false
        switch result {
            
        case .success(let data):
            if data.status ?? false{
                activeAlert = AlertIdentifier(alert: .goBack)
            } else {
                self.showError(message: data.message ?? "")
            }
            debugPrint(data.message ?? "")
        case .failure(let error):
            debugPrint(error.customMessage)
            self.showError(message: error.customMessage)
        }
    }
}
