//
//  UserReviewView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

struct UserReviewView: AppTNowView {
    
    
    let reivew: Review
    
    
    var body: some View {
        VStack(alignment:.leading, spacing: 7) {
            HStack {
                RectangleAysnImageView(url: reivew.user?.image ?? "")
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.gray, lineWidth: 0.4)
                    }
                
                VStack(alignment: .leading) {
                    Text(reivew.user?.name ?? "")
                        .font(AppTNowFont.medium.getFont(size: .h2))
                        .foregroundColor(textColor)
                    Text(reivew.createdAt)
                        .font(AppTNowFont.regular.getFont(size: .h0))
                        .foregroundColor(secondaryTextColor)
                }
                
                Spacer()
                
                RatingView(rating: reivew.rating, textColor: .black)
                
            }
            
            Text(reivew.review)
                .font(AppTNowFont.regular.getFont(size: .h2))
                .foregroundColor(secondaryTextColor)
                .lineLimit(3)
            
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

#if DEBUG
struct UserReviewView_preview:PreviewProvider {
    static var previews: some View {
        UserReviewView(reivew: reviewsForBusiness.first!)
    }
}
#endif
