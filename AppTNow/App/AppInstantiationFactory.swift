//
//  AppInstantiationFactory.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 20/08/2023.
//

import SwiftUI
import GoogleSignIn

final class AppInstantiationFactory {
    
    @ViewBuilder
    func appStart() -> some View {
        NavigationStack {
            if UserManager.shared.isUserLogin() {
                tabbarview
            } else {
                welcomeScreen
            }
        }
        
    }
    
    private var welcomeScreen: some View  {
        WelcomeView()
            .onOpenURL { url in
                print("Received URL: \(url)")
                GIDSignIn.sharedInstance.handle(url)
            }
    }
    
    private var tabbarview: TabbarView  {
        TabbarView()
    }
    
}
