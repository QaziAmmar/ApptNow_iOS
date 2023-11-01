//
//  StyledLineWithText.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct StyledLineWithText: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 5) {
            
            StyledLine(startLocation: 1, endLocation: 0)
            Text(text)
                .font(AppTNowFont.regular.getFont(size: .h2))
                .foregroundColor(Color.color(.secondaryText))
            StyledLine(startLocation: 0, endLocation: 1)
        }
    }
}
