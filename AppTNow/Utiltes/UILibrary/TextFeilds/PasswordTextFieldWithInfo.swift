//
//  PasswordTextFieldWithInfo.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

struct PasswordTextFieldWithInfo: View {
    let title: String
    let placeText: String
    @Binding var text: String
    @Binding var isSecure: Bool
    let xOffset: CGFloat
    let yOffset: CGFloat
    let action: () -> ()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            passwordTextField(
                title: title,
                placeText: placeText,
                text: $text,
                isSecure: $isSecure
            )
            
            Image(systemName: "asterisk")
                .font(.system(size: 8))
                .foregroundColor(.red)
                .offset(x: xOffset, y: yOffset)
            
            Button(action: action , label: {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
            }).offset(x: xOffset + 10, y: 0)
        }
    }
}
