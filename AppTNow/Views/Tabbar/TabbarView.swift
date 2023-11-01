//
//  TabbarView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 20/08/2023.
//

import SwiftUI

struct TabbarView: View {
    @State var goToWelcome: Bool = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            
            ApptHistoryView()
                .tabItem{
                    Label("Appointment", systemImage: "handbag")
                }
            
            SettingView(deleteUser: {
                goToWelcome.toggle()
            })
            .tabItem{
                Label("Profile", systemImage: "person.fill")
            }
        }
        .navigateWith(isActive: $goToWelcome, destination: WelcomeView())
        .tint(.color(.mainColor))
    }
}
#if DEBUG
struct TabbarView_Preview: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
#endif
