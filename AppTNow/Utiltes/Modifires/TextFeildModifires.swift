//
//  TextFeildModifires.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 26/07/2023.
//

import SwiftUI
extension View {
    func customeTextField(title: String = "",
                           placeHolder: String = "",
                           text: Binding<String>,
                           keyboardType: UIKeyboardType = .default) -> some View {
        
        AppTNowTextField(title: title,
                          placeHolder: placeHolder,
                          text: text,
                          titleFont: AppTNowFont.medium.getFont(size: .h2),
                          textFieldFont: AppTNowFont.regular.getFont(size: .h2),
                          keyboardType:keyboardType)
        
    }
    
    func passwordTextField(title: String,
                           placeText: String,
                           text: Binding<String>,
                           isSecure: Binding<Bool>) -> some View {
        
        PasswordTextField(title: title,
                          placeHolder: placeText,
                          ImageName: isSecure.wrappedValue ?  ImageName.Registration.showPasswod.rawValue : ImageName.Registration.hidePassword.rawValue,
                          text: text,
                          isSecure: isSecure,
                          font: AppTNowFont.medium.getFont(size: .h2))
    }
    
    func simpelCountDownTF(title: String,
                           placeHolder: String,
                           text: Binding<String>,
                           startTimer: Binding<Bool>,
                           keyboardType: UIKeyboardType = .default) -> some View {
        
        AppTNowCountDownTextField(title: title,
                                  placeHolder: placeHolder,
                                  text: text,
                                  titleFont: AppTNowFont.medium.getFont(size: .h2),
                                  textFieldFont: AppTNowFont.regular.getFont(size: .h2),
                                  keyboardType:keyboardType, startTimer: startTimer
        )
    }
    
}
