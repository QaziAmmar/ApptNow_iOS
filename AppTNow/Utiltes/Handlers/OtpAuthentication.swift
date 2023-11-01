//
//  OtpAuthentication.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 11/08/2023.
//

import Foundation
import Firebase

enum OtpAuthError: Error {
    case invalidPhoneNumber
    case failedToSendOtp
    case failedToVerifyOtp
    case error(String)
}

enum OtpAuthResult<T> {
    case success(T)
    case failure(OtpAuthError)
}

protocol OtpAuthentication {
    func sendOtpCode(to phoneNumber: String) async -> OtpAuthResult<String>
    func verifyOtp(with verificationID: String, and code: String) async -> OtpAuthResult<Bool>
}

class FirebaseOtpAuth: OtpAuthentication {
    func sendOtpCode(to phoneNumber: String) async -> OtpAuthResult<String> {
        guard !phoneNumber.isEmpty else {
            return .failure(.invalidPhoneNumber)
        }
        do {
            let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            return .success(verificationID)
        } catch let error {
            print(error)
            return .failure(.error(error.localizedDescription))
        }
    }
        
    func verifyOtp(with verificationID: String, and code: String) async -> OtpAuthResult<Bool> {
        guard !verificationID.isEmpty && !code.isEmpty else {
            return .failure(.failedToVerifyOtp)
        }
        do {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
            
            _ = try await Auth.auth().signIn(with: credential)
            return .success(true)
        } catch let  error {
            return .failure(.error(error.localizedDescription))
        }
    }
}

import GoogleSignIn
class GoogleHelper {
    func getGoogleSinginClientID() -> String {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return ""}
        return clientID
    }
    
    func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
