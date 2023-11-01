//
//  AppTNowTextField.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//

import SwiftUI

public struct AppTNowTextField: View {
    
    private let title: String
    private let placeHolder: String
    private let keyboardType: UIKeyboardType
    private let titleFont: Font
    private let textFieldFont: Font
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    
    public init(title: String = "sdas",
                placeHolder: String = "asd",
                text: Binding<String>,
                titleFont: Font = .system(size: 13),
                textFieldFont: Font = .system(size: 13),
                keyboardType: UIKeyboardType = .default) {
        
        self.title = title
        self.placeHolder = placeHolder
        self._text = text
        self.titleFont = titleFont
        self.textFieldFont = textFieldFont
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(titleFont)
                .padding(.bottom, 5)

            TextField(placeHolder, text: $text)
                .font(textFieldFont)
                .padding(15)
                .background(Color.color(.textFeildBackground))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05),radius: 3,x: 0,y: 4)
                .focused($isFocused)
                .frame(height: 56)
                .keyboardType(keyboardType)
                
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTNowTextField(text: .constant(""))
    }
}
