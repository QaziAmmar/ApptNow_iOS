//
//  LoginView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//

import SwiftUI

struct LoginView: AppTNowView {
    
    private struct Config {
        static let wavingHand = ImageName.Registration.wavingHand.rawValue
        static let welcomeBackText = "Welcome Back!"
        static let welcomeBackGreetingText = "Hello again, you’ve been missed!"
        static var email: String = "Email Address"
        static var emailPlaceHolder: String = "Enter your email address"
        static var password: String = "Enter password"
        static var passwordPlaceHolder: String = "Enter your Password"
        static var forgetPassword: String = "Forget Password?"
        static var forgetSubtitle: String = "Don’t worry! it happens. Please enter the email address associated with your account."
    }
    
    @StateObject private var viewModel: LoginVM = LoginVM()
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .navigationDestination(isPresented: $viewModel.moveToHome) {
            TabbarView().hideNavigationBar
        }
        .navigationDestination(isPresented: $viewModel.moveToAddPhoneNumber) {
            OtpViewForPhone(
                title: "Add Phone Number",
                subTitle: "Add your phone number so that you can complete your profile",
                isForPhoneNumber: true,
                callBack: {
                    viewModel.moveToAddPhoneNumber.toggle()
                    GoogleHelper().googleSignOut()
                }
            ).hideNavigationBar
        }
    }
}
// MARK: Basic Component
extension LoginView {
    private var loadView: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            appoientmentView
            welcomeBackView
            textFeilds
            loginButton
            StyledLineWithText(text: "Or Login")
            socailButton
            Spacer()
            alreadyHaveAccount
            
        }.padding(15)
    }
    
    private var appoientmentView: some View {
        AppointmentTopView()
    }
    
    private var welcomeBackView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Config.welcomeBackText)
                    .font(AppTNowFont.medium.getFont(size: .h5))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                
                Text(Config.welcomeBackGreetingText)
                    .font(AppTNowFont.regular.getFont(size: .h2))
                    .multilineTextAlignment(.center)
                    .foregroundColor(secondaryTextColor)
            }
            
            Image(Config.wavingHand)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
        }
    }
    
    private var textFeilds: some View {
        VStack(alignment: .trailing, spacing: 15) {
            ZStack(alignment: .topLeading) {
                
                customeTextField(title: Config.email,
                                 placeHolder: Config.emailPlaceHolder,
                                 text: $viewModel.email, keyboardType: .emailAddress)
                
                asteriskImage(x: 92, y: 4)
                
            }
            
            ZStack(alignment: .topLeading) {
                passwordTextField(title: Config.password,
                                  placeText: Config.passwordPlaceHolder,
                                  text: $viewModel.password,
                                  isSecure: $viewModel.isSecureTextFeild)
                
                asteriskImage(x: 100, y: 4)
                
            }
            
            Text(Config.forgetPassword)
                .font(AppTNowFont.medium.getFont(size: .h1))
                .foregroundColor(appColor)
                .navigate(
                    to: OtpViewViewForEmail(
                        title: Config.forgetPassword,
                        subTitle: Config.forgetSubtitle
                    ).hideNavigationBar
                )
        }
    }
    
    private func asteriskImage(x: CGFloat, y: CGFloat) -> some View {
        Image(systemName: "asterisk")
            .font(.system(size: 6))
            .foregroundColor(.red)
            .offset(x: x, y: y)
    }
    
    private var alreadyHaveAccount: some View {
        AlreadyHaveAccount(title: "Don’t have an account?",
                           buttonTitle: "Sign Up"
                           ,destination: SignUpView())
    }
}
// MARK: Buttons
extension LoginView {
    private var loginButton: some View {
        customButton(
            title: "Log In",
            action: {
                Task {
                    await viewModel.loginUser()
                }
            })
    }
    
    private var socailButton: some View {
        SocialRegisternation(title: "Login",
                             action: viewModel.socialButtonAction)
    }
}
#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
