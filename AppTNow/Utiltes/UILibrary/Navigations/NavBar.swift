//
//  NavBar.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 12/08/2023.
//

import SwiftUI

import SwiftUI

struct NavBar: AppTNowView {
    var title: String
    var navBarColor: Color = .black
    var action: () -> Void
    var rightImageName: String = ""
    var rightBtnAction: (() -> Void)?

    var body: some View {
        HStack {
            backButton
            Spacer()
            if !rightImageName.isEmpty {
                rightButton
            }
        }
        .overlay(titleLabel, alignment: .center)
    }

    private var backButton: some View {
        Button(action: action) {
            VStack {
                Image(ImageName.Common.arrowLeft.rawValue)
                    .resizable()
                .frame(width: 30, height: 30)
                
            }
            .padding(3)
            .frame(width: 40, height: 40, alignment: .center)
            .background(Color.color(.textFeildBackground))
            .cornerRadius(130)
        }
    }

    private var rightButton: some View {
        Button(action: rightBtnAction ?? {}) {
            Image(rightImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                
        }
    }

    private var titleLabel: some View {
        Text(title)
            .font(AppTNowFont.medium.getFont(size: .h5))
            .multilineTextAlignment(.center)
            .foregroundColor(navBarColor)
            .padding(.bottom, 10)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(title: "Setting", action: { print("Back") }, rightImageName: "settings", rightBtnAction: { print("Settings") })
             
    }
}
