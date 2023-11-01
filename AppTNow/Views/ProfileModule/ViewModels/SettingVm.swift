//
//  SettingVm.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 26/08/2023.
//

import SwiftUI

class SettingVm: APPTNowBaseViewModel,RequestManager {
    
    
    @MainActor
    func deleteAccount() async -> Bool {
        showLoader = true
        let request: SettingEndPoints = .deleteAccount
        let result = await sendApiRequest(request: request, responseModel: GenericResponse.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
                UserManager.shared.removeUser()
                GoogleHelper().googleSignOut()
                return true
            } else {
                self.showError(message: data.message ?? "")
                return false
            }
        case .failure(let error):
            self.showError(message: error.customMessage)
            return false
        }
    }
}
