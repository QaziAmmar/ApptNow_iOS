//
//  ResetPasswordView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct ResetPasswordView: AppTNowView {
    
    @StateObject private var viewModel: ResetPasswordVM = ResetPasswordVM()
    
    var body: some View {
        ZStack() {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
    }
}
// MARK: Basic View
extension ResetPasswordView {
    
    private var loadView: some View {
        VStack(alignment: .leading, spacing: 30) {
            resetPasswordView
            textFeilds
            Spacer ()
            resetButton
            
        }.padding(15)
    }
    
    private var resetPasswordView: some View {
        VStack(alignment: .leading) {
            Text("Reset Password")
                .font(AppTNowFont.medium.getFont(size: .h5))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
                .padding(.bottom, 10)
            
            Text("Your new password must be different from previously used passwords.")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .multilineTextAlignment(.leading)
                .foregroundColor(secondaryTextColor)
        }
    }
    
    private var textFeilds: some View {
        VStack(alignment: .leading, spacing: 15) {
            passwordTextField(title: "Password",
                              placeText: "Enter Your Password",
                              text: $viewModel.password,
                              isSecure: $viewModel.isPasswordTextFeild)
            
            passwordTextField(title: "Confirm Password",
                              placeText: "Enter Your Password",
                              text: $viewModel.password,
                              isSecure: $viewModel.isNewPasswordSecure)
            
            
        }
    }
}
// MARK: Buttons
extension ResetPasswordView {
    private var resetButton: some View {
        customButton(
            title: "Reset Password",
            action: {
                Task {
                    await viewModel.resetPassword()
                }
            })
    }
}
#if DEBUG
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
#endif
