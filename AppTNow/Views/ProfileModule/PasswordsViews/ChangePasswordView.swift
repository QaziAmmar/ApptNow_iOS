//
//  ChangePasswordView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 06/08/2023.
//

import SwiftUI

struct ChangePasswordView: AppTNowView {
    
    @StateObject private var viewModel: ChangePasswordVM = ChangePasswordVM()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack() {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(item: $viewModel.activeAlert) { activeAlert in
            switch activeAlert.alert {
            case .showError(let message):
                return Alert(title: Text(message))
            case .goBack:
                return Alert(
                    title: Text("Password Update"),
                    message: Text("Your password has been reset."),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
        }
    }
}
// MARK: Basic View
extension ChangePasswordView {
    
    private var loadView: some View {
        VStack(alignment: .leading, spacing: 30) {
            NavBar(title: "Change Password", action: {dismiss()})
            resetPasswordView
            textFeilds
            Spacer ()
            resetButton
            
        }.padding(15)
    }
    
    private var resetPasswordView: some View {
        VStack(alignment: .leading) {
            Text("Change Password")
                .font(AppTNowFont.medium.getFont(size: .h5))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
                .padding(.bottom, 10)
        }
    }
    
    private var textFeilds: some View {
        VStack(alignment: .leading, spacing: 15) {
            passwordTextField(title: "Old Password",
                              placeText: "Enter Your Password",
                              text: $viewModel.oldPassword,
                              isSecure: $viewModel.isOldPasswordTextFeild)

            passwordTextField(title: "New Password",
                              placeText: "Enter Your Password",
                              text: $viewModel.newPassword,
                              isSecure: $viewModel.isNewPasswordSecure)
            
            passwordTextField(title: "Confirm Password",
                              placeText: "Enter Your Password",
                              text: $viewModel.newConfirmPassword,
                              isSecure: $viewModel.isNewConfrimPasswordSecure)
            
            
        }
    }
}
// MARK: Buttons
extension ChangePasswordView {
    private var resetButton: some View {
        customButton(
            title: "Reset Password",
            action: {
                Task {
                    await viewModel.changePassword()
                }
            })
    }
}
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
