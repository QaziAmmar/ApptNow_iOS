//
//  AppTNowFont.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//
import SwiftUI

enum FontName: String {
    case interRegular = "TripSans-Regular"
    case interMedium = "TripSans-Medium"
    case interBold = "TripSans-Bold"
    case ultra = "TripSans-Ultra"
}

enum AppTNowFont: Int {
    
    case regular = 400
    case medium = 500
    case semiBold = 600
    case bold = 700
    
    private func fontName() -> String {
        switch self {
        case .regular:
            return FontName.interRegular.rawValue
        case .medium:
            return FontName.interMedium.rawValue
        case .semiBold:
            return FontName.ultra.rawValue
        case .bold:
            return FontName.interBold.rawValue
        }
    }
    
    func getFont(size: FontSize) -> Font {
        return Font.custom(fontName(), size: size.rawValue)
    }
}

enum FontSize: CGFloat {
    case h0 = 10
    case h1 = 12
    case h2 = 14
    case h3 = 16
    case h4 = 20
    case h5 = 28
    case h6 = 36
    
    var size: CGFloat {
        phoneFontSize
    }
    
    private var phoneFontSize: CGFloat {
        switch self {
        case .h0:
            return 10.0
        case .h1:
            return 12.0
        case .h2:
            return 14.0
        case .h3:
            return 16
        case .h4:
            return 18
        case .h5:
            return 24
        case .h6:
            return 36
            
        }
    }
}
