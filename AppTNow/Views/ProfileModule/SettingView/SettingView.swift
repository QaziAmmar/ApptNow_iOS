//
//  SettingView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 05/08/2023.
//

import SwiftUI
import PhotosUI

struct SettingView: AppTNowView {
    let deleteUser: () -> ()
    let settings: [SettingSection] = SettingFactory.createSettings()
    
    @State private var showDeleteAlert = false
    
    //    To receive the update form other view
    @AppStorage(UserDefaultEnum.userName.rawValue) var userName: String = (UserManager.shared.get()?.name ?? "Testing Name")
    @AppStorage(UserDefaultEnum.userPhone.rawValue) var userPhone: String = (UserManager.shared.get()?.phone ?? "+234 9011039271")
    @AppStorage(UserDefaultEnum.profileImage.rawValue) var userImageUrl: String = (UserManager.shared.get()?.image ?? "")
    
    
    
    @StateObject private var viewModel: SettingVm = SettingVm()
    
    var body: some View {
        NavigationStack {
            ZStack {
                loadView
                LoaderView(isLoading: $viewModel.showLoader)
            }
            
        }.tint(.black)
    }
}


// MARK: Basic Methods
extension SettingView {
    @ViewBuilder
    private var loadView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                settingTopView
                settingTList
                
                if UserManager.shared.isUserLogin() {
                    logOutButton()
                }
                
            }.padding(15)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Are you sure you want to delete?"),
                message: Text("Your account will be deleted permanently"),
                primaryButton: .destructive(Text("Delete")) {
                    Task {
                        if  await viewModel.deleteAccount() {
                            deleteUser()
                        }
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    @ViewBuilder
    var settingTopView: some View {
        if UserManager.shared.isUserLogin() {
            userImageAndInfo
        } else {
            gestUserImageAndInfo
        }
        
    }
    
    @ViewBuilder
    var gestUserImageAndInfo: some View {
        HStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.color(.mainColor))
                    .frame(width: 50, height: 50)
                    .opacity(0.25)
                Image(ImageName.Setting.userBlue.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
            }
            VStack(alignment: .leading) {
                Text("Guest")
                    .font(AppTNowFont.medium.getFont(size: .h3))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                
                Text("Welcome To Appointment Now")
                    .font(AppTNowFont.regular.getFont(size: .h2))
                    .multilineTextAlignment(.center)
                    .foregroundColor(secondaryTextColor)
            }
            
        }
    }
    
    @ViewBuilder var userImageAndInfo: some View {
        HStack {
            RectangleAysnImageView(
                url: AppUrl.IMAGEURL +  userImageUrl,
                width: 65,
                height: 65
            )
            
            VStack (alignment: .leading){
                Text(userName)
                    .font(AppTNowFont.regular.getFont(size: .h3))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                
                Text(userPhone)
                    .font(AppTNowFont.regular.getFont(size: .h2))
                    .multilineTextAlignment(.center)
                    .foregroundColor(secondaryTextColor)
                
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .navigate(to:
                    EditProfileView()
            .hideNavigationBar
        )
    }
    
    var settingTList: some View {
        ForEach(settings) { setting in
            Section(
                header:
                    Text(setting.section)
                    .font(AppTNowFont.bold.getFont(size: .h3)),
                content: {
                    ForEach(setting.settings) { singleSetting in
                        SettingCell(setting: singleSetting,
                                    deleteUser: {
                            showDeleteAlert.toggle()
                        })
                    }
                })
        }
    }
    
    
    func logOutButton() -> some View {
        NavigationLink {
            WelcomeView()
                .hideNavigationBar
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: 50)
                    .foregroundColor(.color(.mainColor))
                Text("Log Out")
                    .foregroundColor(.white)
                    .font(AppTNowFont.medium.getFont(size: .h3))
            }
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(deleteUser: {})
    }
}



