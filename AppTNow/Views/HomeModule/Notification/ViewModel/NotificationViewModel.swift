//
//  NotifcationVM.swift
//  AppTNowEmplyee
//
//  Created by Qazi Mudassar on 23/09/2023.
//

import SwiftUI

final class NotifcationVM: APPTNowBaseViewModel {
    @Published private (set) var notifications: [NotificatioModel]?
}
// MARK: -
extension NotifcationVM: RequestManager {
//    @MainActor
//    func fetchNotifcations() async {
//
//        self.showLoader = true
//        let request : HomeEndPoint = .getnotifcations
//        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<[NotificatioModel]>.self)
//        self.showLoader = false
//        switch result {
//
//        case .success(let data):
//            debugPrint(data.message ?? "")
//            if data.status ?? false {
//                notifications = data.data
//            } else {
////                showError(message: data.message ?? "")
//            }
//        case .failure(let error):
//            debugPrint(error.customMessage)
//            showError(message: error.customMessage)
//        }
//    }
}

