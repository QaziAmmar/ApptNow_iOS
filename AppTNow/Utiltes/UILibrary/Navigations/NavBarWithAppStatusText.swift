//
//  NavBarWithAppStatusText.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 10/10/2023.
//

import SwiftUI

struct NavBarWithAppStatusText: AppTNowView {

    var title: String
    var navBarColor: Color = .black
    var rightText: String = ""
    var rightTextColor: Color = .red
    var action: () -> Void
    var body: some View {
        HStack(alignment: .center) {
            backButton
            Spacer()
            if !rightText.isEmpty {
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
        Text(rightText)
            .font(AppTNowFont.semiBold.getFont(size: .h1))
            .foregroundColor(rightTextColor)
    }

    private var titleLabel: some View {
        Text(title)
            .font(AppTNowFont.medium.getFont(size: .h4))
            .multilineTextAlignment(.center)
            .foregroundColor(textColor)
            .padding(.bottom, 10)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}

struct NavBarWithAppStatusText_Previews: PreviewProvider {
    static var previews: some View {
        NavBarWithAppStatusText(title: "Appt Detail", rightText: "Cancleed", rightTextColor: .red, action: {debugPrint("back pressed")})
    }
}
