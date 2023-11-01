//
//  HomeView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 03/08/2023.
//

import SwiftUI

struct HomeView: AppTNowView {
    
    @AppStorage(UserDefaultEnum.userName.rawValue) var userName: String = (UserManager.shared.get()?.name ?? "Testing Name")
    @AppStorage(UserDefaultEnum.userPhone.rawValue) var userPhone: String = (UserManager.shared.get()?.phone ?? "+234 9011039271")
    @AppStorage(UserDefaultEnum.profileImage.rawValue) var userImageUrl: String = (UserManager.shared.get()?.image ?? "")
    
    @StateObject var viewModel = HomeViewModel()
    
    @State private var isCallingFirstTime = true

    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        ZStack {
            loadview
            LoaderView(isLoading: $viewModel.showLoader)
            
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .task {
            if isCallingFirstTime {
                await viewModel.fetchBusinessCategoriesAPI()
                await viewModel.fetchBusinessListApi(business_category: "")
                isCallingFirstTime.toggle()
            }
            
        }
        .onChange(of: viewModel.selectedBusinessCategoryID) { newValue in
            Task {
                await viewModel.fetchBusinessListWithCategory()
            }
        }
    }
}

// MARK: - Function Extension
extension HomeView {
    
    
    @ViewBuilder
    var loadview: some View {
        VStack(alignment: .leading, spacing: 20) {
            topNavBar
            SearchBar(text: $viewModel.searchText) {
                debugPrint("On cancle called")
            }
            titleView
            shposCollectionView
            
            Spacer()
        }.padding()
    }

    @ViewBuilder
    var topNavBar: some View {
        if UserManager.shared.isUserLogin() {
            loginUserInfo
        } else {
            guestUserInfo
        }
        
    }
    
    @ViewBuilder
    var titleView: some View {
        Text("Nearby Business Stores")
            .font(AppTNowFont.medium.getFont(size: .h4))
    }
    
}


// MARK: -View Extension
extension HomeView {
//    Top Nav view
    var loginUserInfo: some View {
        HStack {
            CircularAsyncImageView(url: userImageUrl)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(userName)
                        .font(AppTNowFont.medium.getFont(size: .h3))
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                    
                    Image(ImageName.Registration.wavingHand.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                }
                Text("Make appointments and get services near you")
                    .font(Font.custom("Trip Sans", size: 10))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(secondaryTextColor)
            }
            Spacer()
            
            NavigationLink {
                NotifcationView()
                    .hideNavigationBar
            } label: {
                Circle()
                    .foregroundColor(backgroundColor)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "bell.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    )
            }
        }
    }
    
    var guestUserInfo : some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.color(.mainColor))
                    .frame(width: 50, height: 50)
                    .opacity(0.25)
                Image(ImageName.Setting.userBlue.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Guest")
                        .font(AppTNowFont.medium.getFont(size: .h3))
                        .multilineTextAlignment(.center)
                        .foregroundColor(textColor)
                    
                    Image(ImageName.Registration.wavingHand.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                }
                Text("Make appointments and get services near you")
                    .font(Font.custom("Trip Sans", size: 10))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(secondaryTextColor)
            }
            Spacer()

        }
    }
    
// Location is turned of
    @ViewBuilder
    var turnOnLocationView: some View {
        VStack(spacing: 15) {
            Spacer()
            Image(ImageName.Home.location.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
            Text("Turn your location on")
                .font(AppTNowFont.medium.getFont(size: .h3))
            Text("Please open your phone setting and allow the app to access your location so you can view your nearby business stores")
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(secondaryTextColor)
            Spacer()
            customButton(
                title: "Enable Location",
                action: {
                    debugPrint("Enable location view")
                })
        }
    }
    // No business Founded
    @ViewBuilder
    var noBusinessView: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(ImageName.Home.shop.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
            Text("No Business Found within specified area")
                .font(AppTNowFont.medium.getFont(size: .h3))
            Text("We Could’nt found any business store in your area")
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(secondaryTextColor)
            Spacer()
            Divider()
                .opacity(0.001)
        }
    }
    
   
    @ViewBuilder
    var shposCollectionView: some View {
        categoryListView
        
        if viewModel.businesses.isEmpty {
            noBusinessView
        } else {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.businesses) { business in
                        NavigationLink {
                            BusinessDetailView(businessID: business.id ?? 1)
                                .hideNavigationBar
                        } label: {
                            BusinessCellView(business: business)
                        }
                    }
                }
                .padding(.horizontal)
       
            }
        }
        
    }
    
    @ViewBuilder
    var categoryListView: some View {
        if !viewModel.businessCategoriesList.isEmpty {
            HorizontalCategorySelectionView(categories: viewModel.businessCategoriesList, selectedIndex: $viewModel.selectedBusinessCategoryID)
        }
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
