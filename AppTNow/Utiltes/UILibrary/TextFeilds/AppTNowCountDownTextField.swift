//
//  AppTNowCountDownTextField.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct AppTNowCountDownTextField: View {
    
    private let title: String
    private let placeHolder: String
    private let keyboardType: UIKeyboardType
    private let titleFont: Font
    private let textFieldFont: Font
    @Binding var startTimer: Bool
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    
    init(title: String = "sdas",
                placeHolder: String = "asd",
                text: Binding<String>,
                titleFont: Font = .system(size: 13),
                textFieldFont: Font = .system(size: 13),
                keyboardType: UIKeyboardType = .default,
                startTimer: Binding<Bool>) {
        
        self.title = title
        self.placeHolder = placeHolder
        self._text = text
        self.titleFont = titleFont
        self.textFieldFont = textFieldFont
        self.keyboardType = keyboardType
        self._startTimer = startTimer
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(titleFont)
                .padding(.bottom, 5)
            ZStack {
                TextField(placeHolder, text: $text)
                    .font(textFieldFont)
                    .padding(15)
                    .background(Color.color(.textFeildBackground))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.05),radius: 3,x: 0,y: 4)
                    .focused($isFocused)
                    .frame(height: 56)
                    .keyboardType(keyboardType)
                
                if startTimer {
                    HStack {
                        Spacer()
                        CountDownView(startTimer: $startTimer)
                    }
                    
                }
            }
        }
    }
}


struct AppTNowCountDownTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTNowCountDownTextField(text: .constant(""), startTimer: .constant(true))
    }
}
