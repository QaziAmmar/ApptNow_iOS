//
//  ForgetPasswordView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 27/07/2023.
//

import SwiftUI

struct OtpViewForPhone: AppTNowView {
    
    private let title: String
    private let subTitle: String
    private let isForPhoneNumber: Bool
    private let callBack: () -> ()
    
    init(
        title: String,
        subTitle: String,
        isForPhoneNumber: Bool = false,
        callBack: @escaping () -> Void
    ) {
        self.title = title
        self.subTitle = subTitle
        self.isForPhoneNumber = isForPhoneNumber
        self.callBack = callBack
    }
    
    @StateObject private var viewModel: OtpPhoneVM = OtpPhoneVM()
    
    var body: some View {
        ZStack() {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .navigationDestination(isPresented: $viewModel.goToHome) {
            TabbarView()
                .hideNavigationBar
        }
    }
}

extension OtpViewForPhone {
    
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
        NavBar(title: "", action: callBack)
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
        VStack(alignment: .trailing, spacing: 15) {
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
extension OtpViewForPhone {
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
#if DEBUG
struct OtpViewView_Previews: PreviewProvider {
    static var previews: some View {
        OtpViewForPhone(
            title: "Add Phone Number",
            subTitle: "Add your phone number so that you can complete your profile",
            isForPhoneNumber: true,
            callBack: {}
        )
    }
}
#endif
