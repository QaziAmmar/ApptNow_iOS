//
//  HideNavigationBar.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//

import SwiftUI

struct HideNavigationBar : ViewModifier {
    init() {}
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
