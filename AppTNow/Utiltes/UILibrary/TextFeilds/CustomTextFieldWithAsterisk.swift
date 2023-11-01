//
//  CustomTextFieldWithAsterisk.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

struct CustomTextFieldWithAsterisk: View {
    let title: String
    let placeHolder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let xOffset: CGFloat
    let yOffset: CGFloat

    var body: some View {
        ZStack(alignment: .topLeading) {
            customeTextField(
                title: title,
                placeHolder: placeHolder,
                text: $text,
                keyboardType: keyboardType
            )

            Image(systemName: "asterisk")
                .font(.system(size: 6))
                .foregroundColor(.red)
                .offset(x: xOffset, y: yOffset)
        }
    }
}
