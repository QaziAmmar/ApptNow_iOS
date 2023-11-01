//
//  ChangeEmailVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 13/08/2023.
//

import SwiftUI

final class ChangeEmailVM: SocailVM {
    @Published var otp = ""
    @Published var email = UserManager.shared.get()?.email ?? ""
    @Published var isStartTimerForEmail = false
    var otpFromServer = ""
}

extension ChangeEmailVM {
    func sendOTP() async {
        await sendOtponEmail()
    }
    
    func checkMatchOtp() async {
        await matchOtpForEmail()
    }
}
// MARK: OTP handling
extension ChangeEmailVM {
    private func sendOtponEmail() async {
        guard !email.isEmpty else {
            showError(message: "Please add Email the fields.")
            return
        }
        
        guard Validator.shared.isValidEmail(email) else {
            showError(message: "Email is not valid.")
            return
        }
        
        await genrateOTPApi()
    }
    
    private func matchOtpForEmail() async {
        if otp.count == 4 && otpFromServer == otp {
            await matchOTPApi()
        }else {
            self.showError(message: "Add right otp")
        }
    }
    
    private func genrateOTPApi() async {
        self.showLoader = true
        let request: PhoneEndPoints = .generateOtp(email: email)
        
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<OtpRevicerModel>.self)
        self.showLoader = false
        switch result {
        case .success(let data):
            debugPrint(data.message ?? "")
            
            if data.status ?? false {
                otpFromServer = "\(data.data?.otp ?? 0)"
            }else {
                self.showError(message: data.message ?? "")
            }

        case .failure(let error):
            self.showError(message: error.customMessage)
        }
    }
    
    private func matchOTPApi() async {
        self.showLoader = true
        let request: PhoneEndPoints = .verifyOtp(email: email, code: otp)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<User>.self)
        self.showLoader = false
        if handelUser(result: result) {
            await changeEmailApi()
        }
    }
}
// MARK: Change Update Email calling
private extension ChangeEmailVM {
    func changeEmailApi() async {
        self.showLoader = true
        let request : SettingEndPoints = .updateEmail(email: email)
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
