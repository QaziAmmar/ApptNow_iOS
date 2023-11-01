//
//  Loader.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 02/08/2023.
//

import SwiftUI

struct LoaderView: View {
    @Binding var isLoading: Bool

    var body: some View {
        ZStack {
            if isLoading {
                // Transparent background overlay
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.color(.mainColor)))
                        .scaleEffect(2)
                        .padding(30)
                        .background(.white)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onChange(of: isLoading) { newValue in
            withAnimation(.easeInOut) {
            }
        }
    }
}
