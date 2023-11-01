//
//  BusinessCellView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 14/08/2023.
//

import SwiftUI

struct BusinessCellView: AppTNowView {
    let business: Business
    let bottomTextColor: Color = .white
    
    var body: some View {
        ZStack {
            RectangleAysnImageView(url: business.profile!,
                                   width: (UIScreen.main.bounds.size.width/2) - 35 ,
                                   height: (UIScreen.main.bounds.size.width/2) - 35)
            
            VStack(alignment: .leading) {
                RatingView(rating: String(business.averageRating ?? 0.0) )
                Spacer()
                VStack(alignment: .leading) {
                    VStack {
                        HStack(alignment: .center,spacing: 4) {
                            Text(business.name ?? "")
                                .font(AppTNowFont.medium.getFont(size: .h1))
                                .multilineTextAlignment(.center)
                                .foregroundColor(bottomTextColor)
                                .padding(.leading, 5)
                            
                            Spacer ()
                            
                            Text("Mon-Sat")
                                .font(AppTNowFont.medium.getFont(size: .h1))
                                .multilineTextAlignment(.center)
                                .foregroundColor(bottomTextColor)
                                .padding(.trailing, 5)
                        }
                        
                        Text(business.address ?? "")
                            .font(AppTNowFont.regular.getFont(size: .h1))
                            .lineLimit(1)
                            .foregroundColor(bottomTextColor.opacity(0.7))
                            .padding(.leading, 5)
                        
                    }
                    .frame(height: 43)
                    .background(.black.opacity(0.25))
                    .cornerRadius(4)
                }
                .padding(7)
            }
            
        }
        .frame(width: (UIScreen.main.bounds.size.width/2) - 35 , height: (UIScreen.main.bounds.size.width/2) - 35)
        .cornerRadius(5)
    }
}

#if DEBUG
struct BusinessCellView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessCellView(business: mockBusinessList.first!)
    }
}
#endif

struct RatingView: View {
    let rating: String
    var textColor: Color = .white
    
    var body: some View {
        HStack(alignment: .center,spacing: 10) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .frame(width: 10, height: 10)
            Text(rating)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(textColor)
            
            
        }.padding([.horizontal], 7)
        .padding([.vertical], 5)
        .background(Color.white
            .opacity(0.2)
            .cornerRadius(5)
        )
        .padding(10)
        
    }
}
