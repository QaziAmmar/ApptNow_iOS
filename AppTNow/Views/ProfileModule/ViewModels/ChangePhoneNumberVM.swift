//
//  ChangePhoneNumberVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 13/08/2023.
//
import SwiftUI

@MainActor
final class ChangePhoneNumberVM: APPTNowBaseViewModel {
    @Published var phoneNumber = UserManager.shared.get()?.phone ?? ""
    @Published var countaryCode = "+92"
    @Published var otp = ""
    @Published var isStartTimerForPhone = false
    @Published private(set) var fireBaseauthID = ""
    
    private let otpAuthentication: OtpAuthentication = FirebaseOtpAuth()
}
extension ChangePhoneNumberVM {
    func sendOTP() async {
        await sendOtponPhone()
    }
    
    func checkMatchOtp() async {
        await matchOtpForPhone()
    }
}
//MARK: Firebase auth and verify apis
extension ChangePhoneNumberVM {
    private func sendOtponPhone() async {
        guard !phoneNumber.isEmpty else {
            showError(message: "Please add Phone Number the fields.")
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
            self.showError(message: otpAuthError.localizedDescription)
        }
    }
    
    private func matchOtpForPhone() async {
        self.showLoader = true
        let result = await otpAuthentication.verifyOtp(with: fireBaseauthID, and: otp)
        self.showLoader = false
        switch result {
        case .success(let isSignIn):
            if isSignIn {
                await changePhoneNumberApi()
            }else {
                showError(message: "Some Thing went worng")
            }
        case .failure(let otpAuthError):
            self.showError(message: otpAuthError.localizedDescription)
        }
    }
}
// MARK: Phone change APi
extension ChangePhoneNumberVM: RequestManager {
    func changePhoneNumberApi() async {
        let completePhn = "\(countaryCode)\(phoneNumber)"
        self.showLoader = true
        let request : SettingEndPoints = .updateNumber(newPhoneNumber: completePhn)
        let result = await sendApiRequest(request: request, responseModel: GenericResponse.self)
        self.showLoader = false
        switch result {
            
        case .success(let data):
            debugPrint(data.message ?? "")
            if data.status ?? false{
                activeAlert = AlertIdentifier(alert: .goBack)
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            debugPrint(error.customMessage)
            self.showError(message: error.customMessage)
        }
    }
}
