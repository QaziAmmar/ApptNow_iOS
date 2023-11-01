//
//  OtpViewViewForEmail.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 22/08/2023.
//

import SwiftUI

struct OtpViewViewForEmail: AppTNowView {
    
    private let title: String
    private let subTitle: String
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        title: String,
        subTitle: String
    ) {
        self.title = title
        self.subTitle = subTitle
    }
    
    @StateObject private var viewModel: OtpVMForEmail = OtpVMForEmail()
    
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
                    message: Text("Your password has been update.pleas login "),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
        }
        .navigationDestination(isPresented: $viewModel.goToHome) {
            TabbarView()
                .hideNavigationBar
        }
        
    }
}
extension OtpViewViewForEmail {
    
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
        NavBar(title: "", action: {dismiss()})
    }
    
    private var forgetPasswordView: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppTNowFont.medium.getFont(size: .h5))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
                .padding(.bottom, 10)
            
            Text(subTitle)
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
                .foregroundColor(appColor)
                
            })
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
extension OtpViewViewForEmail {
    private var nextButton: some View {
        customButton(
            title: "Next",
            action: {
                Task {
                    await viewModel.checkMatchOtp()
                }
            })
    }
}

struct OtpViewViewForEmail_Previews: PreviewProvider {
    static var previews: some View {
        OtpViewViewForEmail(
            title: "Forget Password",
            subTitle: "Don’t worry! it happens. Please enter the email address associated with your account."
        )
    }
}
