//
//  APPTNowBaseViewModel.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 05/08/2023.
//

import SwiftUI

class APPTNowBaseViewModel: ObservableObject {
    @Published var showLoader = false
    @Published var showError = false
    @Published var activeAlert: AlertIdentifier? = nil
    var errorMessage = ""
    
    
    func showError(message: String) {
        errorMessage = message
        activeAlert = AlertIdentifier(alert: .showError(message: message))
        showError = true
    }
}
