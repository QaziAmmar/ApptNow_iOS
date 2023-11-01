//
//  OtpVMForEmail.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 22/08/2023.
//

import SwiftUI

struct AlertIdentifier: Identifiable {
    var id: UUID = UUID()
    enum ActiveAlert {
        case showError(message: String)
        case goBack
    }
    var alert: ActiveAlert
}

@MainActor
final class OtpVMForEmail : ObservableObject {
    
    @Published var otp = ""
    @Published var email = ""
    @Published var isStartTimerForEmail = false
    @Published var goToHome = false
    @Published var showLoader = false
    @Published var showError = false
    @Published var activeAlert: AlertIdentifier? = nil
    var errorMessage = ""
    var otpFromServer = ""
}
// MARK: - Public Methods
extension OtpVMForEmail {
    func sendOTP() async {
        await sendOtponEmail()
    }
    
    func checkMatchOtp() async {
        await matchOtpForEmail()
    }
 
}
// MARK: - Email OTP
extension OtpVMForEmail: RequestManager {
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
        if otp.count == 6 && otpFromServer == otp {
            await matchOTPApi()
        }else {
            self.showError(message: "Add right otp")
        }
    }
    
    private func genrateOTPApi() async {
        self.showLoader = true
        let request: PhoneEndPoints = .generateOtp(email: email)
        
        let result = await sendApiRequest(request: request,
                                          responseModel: GenericResponseModel<OtpRevicerModel>.self)
        self.showLoader = false
        switch result {
        case .success(let data):
            
            debugPrint(data.message ?? "")
            otpFromServer = "\(data.data?.otp ?? 0)"
            
        case .failure(let error):
            self.showError(message: error.customMessage)
        }
    }
    
    private func matchOTPApi() async {
        self.showLoader = true
        let request: PhoneEndPoints = .verifyOtp(email: email, code: otp)
        let result = await sendApiRequest(request: request,
                                          responseModel: GenericResponseModel<User>.self)
        self.showLoader = false
        if handelUser(result: result) {
            activeAlert = AlertIdentifier(alert: .goBack)
        }
    }
    
    func handelUser(result: Result<GenericResponseModel<User>, RequestError>) -> Bool {
        self.showLoader = false
        switch result {
        case .success(let data):
            if let user: User = data.data {
                UserManager.shared.set(user: user)
                return true
            } else {
                self.errorMessage = data.message ?? ""
                self.showError = true
                return false
            }
        case .failure(let error):
            debugPrint(error.customMessage)
            self.errorMessage = error.customMessage
            self.showError(message: error.customMessage)
            return false
        }
    }
    
    func showError(message: String) {
        errorMessage = message
        activeAlert = AlertIdentifier(alert: .showError(message: message))
    }
}
