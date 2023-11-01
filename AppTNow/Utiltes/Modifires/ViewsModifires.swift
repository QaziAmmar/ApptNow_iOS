//
//  ViewsModifires.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//

import SwiftUI

extension View {
    var hideNavigationBar: some View {
        modifier(
            HideNavigationBar()
        )
    }
    
    func setBackGround(imageName: String) -> some View {
        background(
            Image(imageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .clipped()
        )
    }
    
    func setGradientBackGround() -> some View {
        background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .black.opacity(0.75), location: 0.01),
                    Gradient.Stop(color: .black.opacity(0.15), location: 0.41),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.75)
            )
        )
    }
    
    func navigate<Destination: View>(to destination: Destination) -> some View  {
        modifier(
            GenericNavigationLink(destination: destination)
        )
    }
    
    func navigateWith<Content: View>(isActive: Binding<Bool>,
                                     destination: Content) -> some View {
        modifier(
            NavigationWith(destination: destination,
                           isActive: isActive)
        )
    }
    
    
    func multipleAlerts(alertItem: Binding<AlertItem?>) -> some View {
        modifier(
            MultipleAlerts(alertItem: alertItem)
        )
    }
    
}
