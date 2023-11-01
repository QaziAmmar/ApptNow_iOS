//
//  AppTNowColor.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//

import SwiftUI

enum AppTNowColor: String {
    case mainColor
    case primaryText
    case secondaryText
    case textFeildBackground
    case imagePlaceHolder
    case delete
    
    var color: UIColor {
        UIColor(named: self.rawValue)!
    }
}

extension Color {
    static func color(_ name: AppTNowColor,with opacity: CGFloat = 1) -> Color {
        return Color(name.rawValue).opacity(opacity)
    }
}
