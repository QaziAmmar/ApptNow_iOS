//
//  ButtonModifires.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 26/07/2023.
//

import SwiftUI

extension View {
    func customButton(title: String, backgroundColor: Color = .color(.mainColor),textColor: Color = .white, action: @escaping () -> Void) -> some View {
        AppTNowLongButton(title: title,
                          font: AppTNowFont.medium.getFont(size: .h3),
                          backgroundColor: backgroundColor,
                          textColor: textColor,
                          action: action)
    }
    
    func disableButton(title: String, action: @escaping () -> Void) -> some View {
        AppTNowLongButton(title: title,
                          font: AppTNowFont.medium.getFont(size: .h3),
                          backgroundColor: .color(.textFeildBackground),
                          textColor: .color(.secondaryText),
                          action: action)
        .disabled(true)
    }
    
    func secondaryButton(title: String, action: @escaping () -> Void) -> some View {
        AppTNowLongButton(title: title,
                          font: AppTNowFont.medium.getFont(size: .h3),
                          backgroundColor: .color(.textFeildBackground),
                          textColor: .color(.secondaryText),
                          action: action)
    }
}
