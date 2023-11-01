//
//  Configurable.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

protocol Configurable {
    var appColor: Color { get }
    var textColor: Color { get }
    var secondaryTextColor: Color { get }
    var backgroundColor: Color { get }
    var imagePlaceHolder: Color { get }
    var deleteColor: Color { get }
}

extension Configurable {
    var appColor: Color { .color(.mainColor) }
    var textColor: Color { .color(.primaryText) }
    var secondaryTextColor: Color { .color(.secondaryText) }
    var backgroundColor: Color {.color(.textFeildBackground)}
    var imagePlaceHolder: Color {.color(.imagePlaceHolder)}
    var deleteColor: Color {.color(.delete)}
}

typealias AppTNowView = View & Configurable
