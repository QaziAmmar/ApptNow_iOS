//
//  ChangeEmailView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 13/08/2023.
//

import SwiftUI

struct ChangeEmailView: AppTNowView {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ChangeEmailVM = ChangeEmailVM()
    
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
                    title: Text("Email Update"),
                    message: Text("Your Email has been Update."),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
        }
    }
}

extension ChangeEmailView {
    
    private var loadView: some View {
        VStack(alignment: .leading, spacing: 30) {
            topNavigation
            forgetPasswordView
            textFields
            otpView
            Spacer()
            nextButton
        }
        .padding(15)
    }
    
    private var topNavigation: some View {
        NavBar(title: "Change Email", action: {dismiss()})
    }
    
    private var forgetPasswordView: some View {
        VStack(alignment: .leading) {
            Text("Enter your new password it must be different from previous one")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .multilineTextAlignment(.leading)
                .foregroundColor(secondaryTextColor)
        }
    }
    
    private var textFields: some View {
        VStack(alignment: .trailing, spacing: 5) {
            
            simpelCountDownTF(title: "Email",
                              placeHolder: "Enter Your Email",
                              text: $viewModel.email,
                              startTimer: $viewModel.isStartTimerForEmail)
            
            Button(action: {
                Task {
                    await viewModel.sendOTP()
                }
            },label: {
                Text("Send OTP")
                    .font(AppTNowFont.medium.getFont(size: .h1))
                .foregroundColor(appColor)})
        }
    }
    
    private var otpView: some View {
        VStack {
            
            Text("Please enter the 6 digit authentication password below")
            .font(AppTNowFont.regular.getFont(size: .h2))
            .foregroundColor(secondaryTextColor)
            
            OTPInputView(otp: $viewModel.otp)
                .padding([.trailing,.leading], 10)
        }
    }
}
// MARK: Buttons
extension ChangeEmailView {
    private var nextButton: some View {
        customButton(
            title: "Done",
            action: {
                Task {
                    await viewModel.checkMatchOtp()
                }
            })
    }
}
struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
