//
//  EmptyListView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 27/10/2023.
//

import SwiftUI

struct EmptyListView: AppTNowView {
    var imageName: String = ""
    var descriptionText: String = ""
    var secondaryText: String = ""
    
    
    var body: some View {
        VStack {
            
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
            Text(descriptionText)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
            if !secondaryText.isEmpty {
                Text("")
                    .font(AppTNowFont.regular.getFont(size: .h2))
                    .foregroundColor(secondaryTextColor)
            }
        }
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
