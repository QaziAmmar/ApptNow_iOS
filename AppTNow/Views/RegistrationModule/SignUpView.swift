//
//  SignUpView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct SignUpView: AppTNowView {
    
    private struct Config {
        static let google = ImageName.Registration.google.rawValue
        static let apple = ImageName.Registration.apple.rawValue
    }
    
    @StateObject private var viewModel: SignUpVM = SignUpVM()
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
            passwordPopUpOverlay
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
            
        })
        .navigationDestination(isPresented: $viewModel.moveToAddPhoneNumber) {
            OtpViewForPhone(
                title: "Add Phone Number",
                subTitle: "Add your phone number so that you can complete your profile",
                isForPhoneNumber: true, callBack: {
                    viewModel.moveToAddPhoneNumber.toggle()
                    GoogleHelper().googleSignOut()
                }
            ).hideNavigationBar
        }
        .popup(isPresented: viewModel.showPasswordPopUp,
               alignment: .center,
               direction: .top,
               content: PasswordPopupView.init)
    }
}
// MARK: - Basic View
extension SignUpView {
    @ViewBuilder
    private var passwordPopUpOverlay: some View {
        if viewModel.showPasswordPopUp {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    viewModel.showPasswordPopUp = false
                }
        }
    }
    private var loadView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                appoientmentView
                creatAccountView
                textFeilds
                signupButton
                StyledLineWithText(text: "Or Sign Up With")
                socailButtons
                alreadyHaveAccount
                
            }.padding(15)
        }
    }
    
    private var appoientmentView: some View {
        AppointmentTopView()
    }
    
    private var creatAccountView: some View {
        VStack(alignment: .leading) {
            Text("Create Account")
                .font(AppTNowFont.medium.getFont(size: .h5))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
            
            Text("Create your account and get  services!")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .multilineTextAlignment(.center)
                .foregroundColor(secondaryTextColor)
        }
    }
    
    private var textFeilds: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            CustomTextFieldWithAsterisk(
                title: "Name",
                placeHolder: "Enter Your Name",
                text: $viewModel.name,
                keyboardType: .emailAddress,
                xOffset: 40,
                yOffset: 4
            )
            
            CustomTextFieldWithAsterisk(
                title: "Email Address",
                placeHolder: "Enter Your Email",
                text: $viewModel.email,
                keyboardType: .emailAddress,
                xOffset: 92,
                yOffset: 4
            )
            
            PasswordTextFieldWithInfo(
                title: "Password",
                placeText: "Enter Your Password",
                text: $viewModel.password,
                isSecure: $viewModel.isPasswordTextFeild,
                xOffset: 65,
                yOffset: 4,
                action: {
                    viewModel.showPasswordPopUp.toggle()
                })
            
            PasswordTextFieldWithInfo(
                title: "Confirm Password",
                placeText: "Enter Your Password",
                text: $viewModel.newPassword,
                isSecure: $viewModel.isNewPasswordSecure,
                xOffset: 117,
                yOffset: 4,
                action: {
                    viewModel.showPasswordPopUp.toggle()
                })
            
            
            TermsAndConditaionView()
        }
    }
    
    private var alreadyHaveAccount: some View {
        AlreadyHaveAccount(title: "Already have an account?",
                           buttonTitle: "Login",
                           destination: LoginView())
    }
    
}

// MARK: Buttons
extension SignUpView {
    private var signupButton: some View {
        customButton(
            title: "Sign Up",
            action: {
                Task {
                    await viewModel.signUpUser()
                }
            })
    }
    
    private var socailButtons: some View {
        SocialRegisternation(title: "Sign up", action: { type in
            Task {
                if await viewModel.getToken(with: type) {
                    viewModel.moveToAddPhoneNumber.toggle()
                }
            }
        })
    }
}
#if DEBUG
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
#endif
