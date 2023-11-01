//
//  AppTNowLongButton.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 26/07/2023.
//

import SwiftUI

public struct AppTNowLongButton: View {
    
    private let action: () -> Void
    private let title: String
    private let font: Font
    private let backgroundColor: Color
    private let textColor: Color
    
    public init(title: String,
                font: Font = .system(size: 15),
                backgroundColor: Color = .clear,
                textColor: Color = .white,
                action: @escaping () -> Void) {
        self.title = title
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(height: 50)
                    .foregroundColor(backgroundColor)
                Text(title)
                    .foregroundColor(textColor)
                    .font(font)
            }
        }
    }
}

struct BlueButton_Previews: PreviewProvider {
    static var previews: some View {
        AppTNowLongButton(title: "Login", backgroundColor: .black, action: {})
            .previewLayout(.sizeThatFits)
    }
}

