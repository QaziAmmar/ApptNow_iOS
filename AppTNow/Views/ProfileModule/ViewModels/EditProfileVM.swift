//
//  EditProfileVM.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 13/08/2023.
//

import Foundation
import UIKit

@MainActor
final class EditProfileVM: APPTNowBaseViewModel {
    @Published var name = UserManager.shared.get()?.name ?? ""
    @Published var userImageURL = UserManager.shared.get()?.image ?? ""
    
    override init() {
        
    }
    
}
extension EditProfileVM: RequestManager {
    func updateProfileApi(base64Image: String) async {
        
        
        let endPoint: SettingEndPoints = .updateProfile(image: base64Image, name: name)
        let result = await sendApiRequest(request: endPoint, responseModel: GenericResponseModel<User>.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
//                is use to boradcast the value to the view
                UserDefaults.standard.set(name, forKey: UserDefaultEnum.userName.rawValue)
                UserDefaults.standard.set(data.data?.image, forKey: UserDefaultEnum.profileImage.rawValue)
                UserManager.shared.updateName(name)
                UserManager.shared.updateImage(data.data?.image ?? "")
                
                activeAlert = AlertIdentifier(alert: .goBack)
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            showError(message: error.customMessage)
        }
    }
}
