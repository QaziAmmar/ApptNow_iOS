//
//  PasswordTextField.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 27/07/2023.
//

import SwiftUI

struct PasswordTextField: View {
    private let title: String
    private let placeHolder: String
    private let ImageName: String
    private let keyboardType: UIKeyboardType
    private let font: Font
    @Binding private var text: String
    @Binding var isSecure: Bool
    @FocusState private var isFocused: Bool
    
    
    public init(title: String = "",
                placeHolder: String = "",
                ImageName: String = "",
                text: Binding<String>,
                isSecure: Binding<Bool>,
                font: Font = .system(size: 13),
                keyboardType: UIKeyboardType = .default) {
        
        self.title = title
        self.placeHolder = placeHolder
        self.ImageName = ImageName
        self._text = text
        self._isSecure = isSecure
        self.font = font
        self.keyboardType = title.lowercased().contains("price") ? .numberPad : keyboardType
    }
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(font)
                .padding(.bottom, 5)
            ZStack(alignment: .trailing) {
                
                Group {
                    isSecure ? AnyView(secureTF()) : AnyView( normalTF())
                }
                
                Button {
                    isSecure.toggle()
                } label: {
                    Image(ImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 17)
                        .padding(.trailing)
                }
            }
        }
    }
    
    func secureTF() -> some View {
        
        SecureField(placeHolder, text: $text)
            .font(font)
            .focused($isFocused)
            .padding(15)
            .background(Color.color(.textFeildBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.05),radius: 3,x: 0,y: 4)
            .foregroundColor(Color.black)
            .frame( height: 56)
        
    }
    
    func normalTF() -> some View {
        TextField(placeHolder, text: $text)
            .font(font)
            .padding(15)
            .background(Color.color(.textFeildBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.05),radius: 3,x: 0,y: 4)
            .focused($isFocused)
            .foregroundColor(Color.black)
            .frame( height: 56)
        
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(text: .constant("123"), isSecure: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
