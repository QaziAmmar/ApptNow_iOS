//
//  SocailVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 05/08/2023.
//

import SwiftUI
import MLBranchSSO

@MainActor
class SocailVM: APPTNowBaseViewModel, RequestManager {
    
     func socailLoginAPI(with type: SSO, token: String) async -> Bool {
        self.showLoader = true
        let request: AuthEndPoint = .socialLogin(socialKey: type.rawValue, socialToken: token)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<User>.self)
        return handelUser(result: result)
    }
    
    func handelUser(result: Result<GenericResponseModel<User>, RequestError>) -> Bool {
        self.showLoader = false
        switch result {
        case .success(let data):
            
            if let user : User = data.data {
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
    
    func getToken(with type: SSO) async -> Bool {
        guard let presenting = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return false}
        let config = type == .google ? GoogleHelper().getGoogleSinginClientID(): ""
        let socialType = SSOAuthenticationFactory.createSSOAuthenticaQtion(with: type)
        do {
            let token = try await socialType.fetchSSOToken(with: config, presenter: presenting)
            return await socailLoginAPI(with: type, token: token)
        }catch let error {
            self.showError(message: error.localizedDescription)
            return false
        }
    }
}

