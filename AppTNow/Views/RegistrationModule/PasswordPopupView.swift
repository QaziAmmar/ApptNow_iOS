//
//  PasswordPopupView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI
struct PasswordPopupView: AppTNowView {
    
    var body: some View  {
        HStack(alignment: .top) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                
                Text("Password must have 8-12 characters")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                
                Text("Password must have at least 1 number")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                Text("Password must have at least 1 special character")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .multilineTextAlignment(.center)
                .foregroundColor(textColor)}
        }.padding()
        .background(.white)
        .cornerRadius(10)
    }
}
#if DEBUG
struct PasswordPopupView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordPopupView()
    }
}
#endif
