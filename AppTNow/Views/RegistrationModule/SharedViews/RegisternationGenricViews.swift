//
//  AppointmentTopView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI
import MLBranchSSO

// MARK: AppointmentTopView
struct AppointmentTopView: View {
    
    private struct Config {
        static let appoientNow = ImageName.Registration.appointmentNow.rawValue
        static let appoientNowText = "Appointment Now"
        static let appColor: Color = .color(.mainColor)
    }
    
    var body: some View {
        HStack {
            Image(Config.appoientNow)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
            
            Text(Config.appoientNowText)
                .font(AppTNowFont.bold.getFont(size: .h4))
                .multilineTextAlignment(.center)
                .foregroundColor(Config.appColor)
        }
    }
}
// MARK: SocialRegisternation
struct SocialRegisternation: View {
    private struct Config {
        static let google = ImageName.Registration.google.rawValue
        static let apple = ImageName.Registration.apple.rawValue
    }
    let title: String
    let action: (SSO) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            SocailButton(
                action: {
                    action(.google)
                },
                title: "\(title) with Google",
                image: Config.google)
            
            SocailButton(
                action: {
                    action(.apple)
                },
                title: "\(title) with Apple",
                image: Config.apple)
            
        }
    }
}
// MARK: AlreadyHaveAccount
struct AlreadyHaveAccount <Destination: View>: View {
        
    let title: String
    let buttonTitle: String
    let destination: Destination
    
    var body: some View{
        HStack {
            Spacer()
            Text(title)
                .font(AppTNowFont.regular.getFont(size: .h3))
                .foregroundColor(.color(.primaryText))
            
            Text(buttonTitle)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(.color(.mainColor))
                .navigate(to: destination.hideNavigationBar)
            
            Spacer()
        }
    }
}

struct TermsAndConditaionView : View {
    var body: some View {
        Group {
            Text("By Signing up, you're agree to our ")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .foregroundColor(.color(.secondaryText)) +
            
            Text("Terms & Conditions")
                .font(AppTNowFont.medium.getFont(size: .h2))
                .foregroundColor(.color(.mainColor)) +
            
            Text(" and ")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .foregroundColor(.color(.secondaryText)) +
            
            Text("Privacy Policy.")
                .font(AppTNowFont.medium.getFont(size: .h2))
                .foregroundColor(.color(.mainColor))
        }
    }
}
