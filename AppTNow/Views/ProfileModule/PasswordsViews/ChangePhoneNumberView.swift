//
//  ChangePhoneNumberView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 13/08/2023.
//

import SwiftUI

struct ChangePhoneNumberView: AppTNowView {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: ChangePhoneNumberVM = ChangePhoneNumberVM()
    
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
                    title: Text("Phone Update"),
                    message: Text("Your Phone has been Update."),
                    dismissButton: .default(Text("OK")) {
                        dismiss()
                    }
                )
            }
        }
    }
}

extension ChangePhoneNumberView {
    
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
        NavBar(title: "Change Phone Number", action: {dismiss()})
    }
    
    private var forgetPasswordView: some View {
        VStack(alignment: .leading) {
       
            Text("Just enter your Old phone number so can we can send you a verification code to continue")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .multilineTextAlignment(.leading)
                .foregroundColor(secondaryTextColor)
        }
    }
    
    private var textFields: some View {
        VStack(alignment: .trailing, spacing: 5) {
            
            CountryTextField(countryCode: $viewModel.countaryCode, phoneNumber: $viewModel.phoneNumber, startTimer: $viewModel.isStartTimerForPhone)
            
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
extension ChangePhoneNumberView {
    private var nextButton: some View {
        customButton(
            title: "Change Phone Number",
            action: {
                Task {
                    await viewModel.checkMatchOtp()
                }
            })
    }
}

struct ChangePhoneNumberView_Preview:PreviewProvider {
    static var previews: some View {
        ChangePhoneNumberView()
    }
}
