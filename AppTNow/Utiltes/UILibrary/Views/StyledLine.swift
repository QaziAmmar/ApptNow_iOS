//
//  StyledLine.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct StyledLine: View {
    let startLocation: Double
    let endLocation: Double
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height: 1)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.5, green: 0.5, blue: 0.5), location: min(startLocation, endLocation)),
                        Gradient.Stop(color: Color(red: 0.5, green: 0.5, blue: 0.5).opacity(0), location: max(startLocation, endLocation)),
                    ],
                    startPoint: UnitPoint(x: 0, y: -1),
                    endPoint: UnitPoint(x: 1, y: 0)
                )
            )
    }
}

