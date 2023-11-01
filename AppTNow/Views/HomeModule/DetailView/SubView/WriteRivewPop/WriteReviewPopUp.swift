//
//  WriteReviewPopUp.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 26/10/2023.
//

import SwiftUI

struct WriteReviewPopUp: AppTNowView {
    
    @State private var message = ""
    @State private var rating = 0
    @Binding var showingReviewPopup: Bool
    @ObservedObject var viewModel: BusinessDetailViewModel
    var businessID: Int
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
            
        }
            .alert(isPresented: $viewModel.showError, content: {
                Alert(title: Text(viewModel.errorMessage))
            })
    }
}


// MARK: - View Extension

extension WriteReviewPopUp {
    
    @ViewBuilder
    private var loadView: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Write a review")
                .font(AppTNowFont.medium.getFont(size: .h4))
                .foregroundColor(textColor)
            assignRatingView
            
            descriptionView
            customButton(title: "Done") {
                Task {
                    let result = await viewModel.writeReview(businessID: String(businessID), message: message, rating: String(rating))
                    if result {
                        showingReviewPopup.toggle()
                    }
                    
                }
            }
            
            customButton(title: "Cancle", backgroundColor: .gray.opacity(0.25), textColor: .gray) {
                showingReviewPopup.toggle()
            }
            
        }.padding()
    }
    
    @ViewBuilder
    private var assignRatingView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Rate Company")
                .font(AppTNowFont.medium.getFont(size: .h2))
                .foregroundColor(textColor)
            StarRatingView(rating: $rating)
        }.padding(.bottom)
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Message")
                .font(AppTNowFont.medium.getFont(size: .h2))
                .foregroundColor(textColor)
            
            VStack {
                
                TextField("", text: $message ,axis: .vertical)
                    .lineLimit(2...5)
                    .font(.system(size: 13))
                Spacer()
                
            }   .padding(15)
                .frame(height: 125)
                .background(backgroundColor.opacity(0.5))
                .cornerRadius(10)
        }
    }
    
}


struct WriteReviewPopUp_Previews: PreviewProvider {
    static var previews: some View {
        WriteReviewPopUp(showingReviewPopup: .constant(false), viewModel: BusinessDetailViewModel(), businessID: 1)
    }
}
