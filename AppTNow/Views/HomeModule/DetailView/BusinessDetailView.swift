//
//  DetailView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 16/08/2023.
//

import SwiftUI


struct BusinessDetailView: AppTNowView {
    
    var businessID: Int
    @StateObject var viewModel = BusinessDetailViewModel()
    @State private var showingReviewPopup = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
            
        }.task {
            await viewModel.businessDetail(businessId: String(businessID))
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .sheet(isPresented: $showingReviewPopup) {
            WriteReviewPopUp(showingReviewPopup: $showingReviewPopup, viewModel: viewModel, businessID: businessID)
                .presentationDetents([.medium, .large])
        }
    }
}
extension BusinessDetailView {
    
    @ViewBuilder
    private var loadView: some View {
        VStack() {
            ScrollView {
                topImageView
                VStack(alignment: .leading, spacing: 15) {
                    titleAndSubtitleView
                    serviceView
                    WeeksDaysView(daysTimings: (viewModel.business?.businessTimings) ?? [])
                    imagesRow
                    mapView
                    commentedView
                    
                }.padding(15)
                
            }.ignoresSafeArea()
            
            getServices
        }
    }
    
    private var topImageView: some View {
        
        ZStack(alignment: .top) {
            RectangleAysnImageView(url: viewModel.business?.profile ?? "", width: UIScreen.main.bounds.width + 1, height: 350)
            
            NavBar(title: "Detail",navBarColor: .white, action: {
                self.dismiss()
            }, rightImageName: viewModel.isBusinessSaved ? ImageName.Detail.like.rawValue : ImageName.Detail.unLike.rawValue) {

                Task {
                    await viewModel.saveBusinessWith(businessID: String(businessID), status: viewModel.isBusinessSaved ? "0" : "1")
                }
                 
                
            }.padding(.top, 46)
                .padding()
            
            
        }
    }
    
    private var titleAndSubtitleView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.business?.name ?? "")
                    .font(AppTNowFont.medium.getFont(size: .h5))
                    .foregroundColor(textColor)
                Spacer()
                RatingView(rating: String(viewModel.business?.averageRating ?? 0), textColor: .black)
            }
            
            HStack(spacing: 5) {
                Image(ImageName.Common.mapPin.rawValue)
                    .frame(width: 16, height: 16)
                Text(viewModel.business?.address ?? "")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .foregroundColor(secondaryTextColor)
                    .lineLimit(1)
                
            }
            
            HStack(spacing: 5) {
                Image(ImageName.Registration.time.rawValue)
                    .frame(width: 16, height: 16)
                Text(viewModel.getBusinessTimings())
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .foregroundColor(secondaryTextColor)
                    .lineLimit(1)
                
            }
        }
    }
    
    @ViewBuilder
    private var serviceView: some View {
        Text("Serive")
            .font(AppTNowFont.medium.getFont(size: .h3))
            .foregroundColor(textColor)
        
        WrappedHStack(viewModel.business?.services ?? []) { service in
            HStack {
                CircularAsyncImageView(url: service.image, size: 20)
                Text(service.name)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(AppTNowFont.regular.getFont(size: .h1))
            }
                .padding([.horizontal])
                .padding([.vertical], 10)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
    }
    
    private var imagesRow: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHStack(alignment: .top, spacing: 13) {
                ForEach(viewModel.business?.businessImages ?? []) { businessImage in
                    PosterView(url: businessImage.image)
                    
                }
            }
        }
    }
    
    @ViewBuilder
    private var mapView: some View {
        Text("Loctaion")
            .font(AppTNowFont.medium.getFont(size: .h3))
            .foregroundColor(textColor)
        
        MapView(latitude: Double(viewModel.business?.latitude ?? "0.0")!, longitude: Double(viewModel.business?.longitude ?? "0.0")!)
            .frame(height: 170)
            .cornerRadius(5)
    }
    
    private var noBusinessView: some View {
        NoBusinessReviewsView()
            .frame(maxWidth: .infinity, alignment: .center)
    }
    @ViewBuilder
    private var writeReviewView: some View {
        HStack {
            Text("Company reviews")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
            Spacer()
            
            Button {
                showingReviewPopup.toggle()
            } label: {
                Text("Write a review")
                    .font(AppTNowFont.medium.getFont(size: .h2))
                    .foregroundColor(.red)
            }
            
        }
    }
    
    
    @ViewBuilder
    private var commentedView: some View {
        VStack {
            
            writeReviewView
            
            if (viewModel.business?.reviews?.count == 0) {
                noBusinessView
            } else {
                ForEach(viewModel.business?.reviews ?? []) {review in
                    UserReviewView(reivew: review)
                }
            }
        }
    }
    
    @ViewBuilder
    private var getServices: some View {
        
        NavigationLink {
            ServicesListView(services: viewModel.business?.services ?? [])
                .hideNavigationBar
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: 50)
                    .foregroundColor(viewModel.business?.services?.isEmpty ?? true ? .gray: .color(.mainColor))
                Text("Get Service")
                    .foregroundColor(.white)
                    .font(AppTNowFont.medium.getFont(size: .h3))
            }
        }.padding(15)
            .disabled(viewModel.business?.services?.isEmpty ?? true)

        
        
        
    }
}
#if DEBUG
struct BusinessDetailViewc_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetailView(businessID: 1)
    }
}
#endif
