//
//  ForgetVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

@MainActor
final class OtpPhoneVM : SocailVM {
    
    private let otpAuthentication: OtpAuthentication = FirebaseOtpAuth()
    
    @Published var otp = ""
    @Published var phoneNumber = ""
    @Published var countaryCode = "+92"
    @Published var isStartTimerForPhone = false
    @Published var goToHome = false
    @Published var goBack = false
    @Published var fireBaseauthID = ""
    var otpFromServer = ""
}
// MARK: - Public Methods
extension OtpPhoneVM {
    func sendOTP() async {
        await  sendOtponPhone()
    }
    
    func checkMatchOtp() async {
        await  matchOtpForPhone()
    }
}
// MARK: - Phone OTP
extension OtpPhoneVM {
    private func sendOtponPhone() async {
        guard !phoneNumber.isEmpty else {
            showError(message: "Please add Phone Number the fields.")
            return
        }
        
        guard Validator.shared.isValidPhoneNumber(phoneNumber) else {
            showError(message: "Phone Number is not valid.")
            return
        }
        
        self.showLoader = true
        let completePhn = "\(countaryCode)\(phoneNumber)"
        let result = await otpAuthentication.sendOtpCode(to: completePhn)
        self.showLoader = false
        switch result {
        case .success(let verfiactionID):
            fireBaseauthID = verfiactionID
        case .failure(let otpAuthError):
            errorHandling(otpAuthError)
        }
    }
    
    private func matchOtpForPhone() async {
        guard !otp.isEmpty else {
            showError(message: "Please Enter otp first.")
            return
        }
        
        self.showLoader = true
        let result = await otpAuthentication.verifyOtp(with: fireBaseauthID, and: otp)
        self.showLoader = false
        switch result {
        case .success(let isSignIn):
            if isSignIn {
                goToHome.toggle()
            }else {
                showError(message: "Some Thing went worng")
            }
        case .failure(let otpAuthError):
            errorHandling(otpAuthError)
        }
    }
    
    private func errorHandling(_ otpAuthError: (OtpAuthError)) {
        switch otpAuthError {
        case .error(let errorDescription):
            self.showError(message: errorDescription)
        default:
            self.showError(message: otpAuthError.localizedDescription)
        }
    }
}
