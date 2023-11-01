//
//  SettingFactory.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 06/08/2023.
//

import SwiftUI

struct SettingFactory {
    enum SettingItemType {
        case changePassword
        case changePhoneNumber
        case changeEmailAddress
        case savedBusinessStores
        case myRewards
        case location
        case notification
        case privacyPolicy
        case termsAndConditions
        case login
        case deleteAccount
    }
    
    static func createSettings() -> [SettingSection] {
        
        
        var generalSettings: [SettingSubModel]  = []
        
        var supportSettings: [SettingSubModel]  = [
            SettingItemType.privacyPolicy.createSetting(),
            SettingItemType.termsAndConditions.createSetting(),
        ]
        
        if UserManager.shared.isUserLogin() {
            
            generalSettings.append(SettingItemType.changePassword.createSetting())
            generalSettings.append(SettingItemType.changeEmailAddress.createSetting())
            generalSettings.append(SettingItemType.myRewards.createSetting())
            generalSettings.append(SettingItemType.savedBusinessStores.createSetting())
            generalSettings.append(SettingItemType.notification.createSetting())
            supportSettings.insert(SettingItemType.deleteAccount.createSetting(), at: 2)
        } else {
            generalSettings.insert(SettingItemType.login.createSetting(), at: 0)
            generalSettings.append(SettingItemType.notification.createSetting())
        }

        return [
            SettingSection(section: "General", settings: generalSettings),
            SettingSection(section: "Support", settings: supportSettings)
        ]
    }
}
extension SettingFactory.SettingItemType {
    func createSetting() -> SettingSubModel {
        switch self {
        case .changePassword:
            return SettingSubModel(image: ImageName.Setting.lock.rawValue,
                                   title: "Change Password",
                                   isToggel: false,
                                   destination: AnyView(ChangePasswordView().hideNavigationBar))
        case .changePhoneNumber:
            return SettingSubModel(image: ImageName.Setting.phone.rawValue,
                                   title: "Change Phone number",
                                   isToggel: false,
                                   destination: AnyView(ChangePhoneNumberView().hideNavigationBar))
        case .changeEmailAddress:
            return SettingSubModel(image: ImageName.Setting.letter.rawValue,
                                   title: "Change Email Address",
                                   isToggel: false,
                                   destination: AnyView(ChangeEmailView().hideNavigationBar))
        case .savedBusinessStores:
            return SettingSubModel(image: ImageName.Setting.bookmark.rawValue,
                                   title: "Saved Business Stores",
                                   isToggel: false,
                                   destination: AnyView(SaveBusinessView().hideNavigationBar))
        case .location:
            return SettingSubModel(image: ImageName.Setting.map.rawValue,
                                   title: "Location",
                                   isToggel: true,
                                   destination: nil)
        case .notification:
            return SettingSubModel(image: ImageName.Setting.bell.rawValue,
                                   title: "Notification",
                                   isToggel: true,
                                   destination: nil)
        case .login:
            return SettingSubModel(image: ImageName.Setting.login.rawValue,
                                   title: "Login to your account",
                                   isToggel: false,
                                   destination: AnyView(LoginView()))
        case .privacyPolicy:
            return SettingSubModel(image: ImageName.Setting.shield.rawValue,
                                   title: "Privacy Policy",
                                   isToggel: false,
                                   destination: AnyView(WebViewApptNow(
                                    title: "Privacy Policy",
                                    url: "https://appt-panel.ml-bench.com/PrivacyPolicy.html")
                                        .hideNavigationBar
                                ))
        case .termsAndConditions:
            return SettingSubModel(image: ImageName.Setting.document.rawValue,
                                   title: "Terms and Conditions",
                                   isToggel: false,
                                   destination:  AnyView(WebViewApptNow(
                                    title: "Terms and Conditions",
                                    url: "https://appt-panel.ml-bench.com/TermsCondition.html")
                                        .hideNavigationBar
                                ))
        case .deleteAccount:
            return SettingSubModel(image: ImageName.Setting.userDelete.rawValue,
                                   title: "Delete Account",
                                   isToggel: false,
                                   destination: nil)
        case .myRewards:
            return SettingSubModel(image: ImageName.Setting.reward.rawValue,
                                   title: "My Rewards",
                                   isToggel: false,
                                   destination: AnyView(Text("My Reward")))
        }
    }
}
