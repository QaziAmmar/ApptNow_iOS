//
//  GenricNavgationLink.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 27/07/2023.
//

import SwiftUI

struct GenericNavigationLink<Destination: View>: ViewModifier {
    let destination: Destination
    
    func body(content: Content) -> some View {
        NavigationLink(destination: destination) {
            content
        }
    }
}


struct NavigationWith<Destination: View>: ViewModifier {

    let destination: Destination
    @Binding var isActive: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isActive)
                .blur(radius: isActive ? 3 : 0)
            
            if isActive {
                destination
            }
        }
    }
}
