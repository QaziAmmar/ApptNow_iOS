//
//  SocailButton.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct SocailButton: View {
    let action: () -> Void
    let title: String
    let image: String
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(.white)
                
                HStack {
                    Image(image)
                    Text(title)
                        .font(AppTNowFont.regular.getFont(size: .h2))
                        .foregroundColor(.color(.secondaryText))
                }
            }
        }
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 0)
    }
    
}
