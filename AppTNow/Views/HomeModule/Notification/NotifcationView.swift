//
//  NotifcationView.swift
//  AppTNowEmplyee
//
//  Created by Qazi Mudassar on 19/09/2023.
//

import SwiftUI

struct NotifcationView: AppTNowView {
    
    @StateObject private var viewModel: NotifcationVM = NotifcationVM()
    @EnvironmentObject var router: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    var userName = UserManager.shared.get()?.name ?? ""
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .task {
//           await viewModel.fetchNotifcations()
        }
    }
}
private extension NotifcationView {
    var loadView: some View {
        VStack {
            topNavigation
                .padding(.bottom)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    notficationWelcomeView
                    if viewModel.notifications?.count ?? 0 > 0 {
                        notficationAllCell
                    }
                }
            }
        }.padding()
    }
    
    var topNavigation: some View {
        NavBar(title: "Notifications", action: {
//            router.pop()
            self.dismiss()
        })
    }
    
    var notficationAllCell: some View {
        ForEach(viewModel.notifications ?? [], id: \.id) { notification in
            notficationCellView(notifcation: notification)
        }
    }
    
    var notficationWelcomeView: some View {
        HStack(alignment: .top) {
            Image(ImageName.Common.apptNowWelcome.rawValue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Welcome Back!")
                    .font(AppTNowFont.medium.getFont(size: .h3))
                
                Text("Welcome back \(userName) Accept appointment requests, give service and get feedback about your service")
                    .font(Font.custom("Trip Sans", size: 10))
                    .foregroundColor(textColor)
                
            }
        }
    }
    
    func notficationCellView(notifcation: NotificatioModel) -> some View {
        HStack(alignment: .top) {
            Image(notifcation.icon)
                .frame(width: 25,height: 25)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(notifcation.header)
                    .font(AppTNowFont.medium.getFont(size: .h3))
                    
                Text(notifcation.message)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(Font.custom("Trip Sans", size: 10))
                    .foregroundColor(textColor)
            }
        }
    }
    
    @ViewBuilder
    var notificationEmptyView: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Image(ImageName.Notification.noticationEmpty.rawValue)
                Spacer()
            }
            
            Text("No Notifications yet")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
            Spacer()
        }
    }
}
#if DEBUG
struct NotifcationView_Previews: PreviewProvider {
    static var previews: some View {
        NotifcationView()
    }
}
#endif
