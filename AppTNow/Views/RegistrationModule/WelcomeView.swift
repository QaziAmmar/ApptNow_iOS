//
//  WelcomeView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 26/07/2023.
//

import SwiftUI

struct WelcomeView: AppTNowView {
    
    private struct Config {
        static let backGroundImage = ImageName.Registration.welcomeBackground.rawValue
        static let title = "Need Someone To Serve You?"
        static let subtitle = "Discover the business market and  get service through appointment now"
        static let joinNow = "Join Now"
        static let Later = "Later"
    }
    
    @State var goToLogin = false
    @State var goToHome = false
    
    var body: some View {
            VStack {
                backgroundImage
                welcomeContent
            }.navigationDestination(isPresented: $goToLogin) {
                LoginView()
                    .hideNavigationBar
             }
            .navigationDestination(isPresented: $goToHome) {
                TabbarView()
                    .hideNavigationBar
             }
        .onAppear {
            UserManager.shared.removeUser()
        }
    }
}
// MARK: Basic Components
extension WelcomeView {
    private var backgroundImage: some View {
        Image(Config.backGroundImage)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.top)
            .frame(height: UIScreen.main.bounds.height / 2)
    }
    
    private var welcomeContent: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text(Config.title)
                    .font(AppTNowFont.bold.getFont(size: .h6))
                    .foregroundColor(appColor)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(Config.subtitle)
                    .font(AppTNowFont.regular.getFont(size: .h3))
                    .foregroundColor(secondaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            customButton(title: Config.joinNow, action: {
                goToLogin.toggle()
            })
            
            secondaryButton(title: Config.Later, action: {
                goToHome.toggle()
            })
        
            alreadyHaveAccount
            
        }.padding(15)
    }
    
    private var alreadyHaveAccount: some View {
        AlreadyHaveAccount(title: "Already have an account?",
                           buttonTitle: "Login",
                           destination: LoginView())
    }
}
#if DEBUG
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
#endif
