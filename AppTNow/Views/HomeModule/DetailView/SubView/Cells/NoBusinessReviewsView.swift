//
//  NoBusinessReviewsView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

struct NoBusinessReviewsView: AppTNowView {
    var body: some View {
        VStack {
            
            Image(ImageName.Detail.noCommont.rawValue)
            Text("No Business Reviews Yet")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
            Text("Be the first to add business review")
                .font(AppTNowFont.regular.getFont(size: .h2))
                .foregroundColor(secondaryTextColor)
            
//            Button(action: {}, label: {
//                Text("Write a review")
//                    .font(AppTNowFont.regular.getFont(size: .h2))
//                    .foregroundColor(appColor)
//            })
        }
    }
}
#if DEBUG
struct NoBusinessReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        NoBusinessReviewsView()
    }
}
#endif
