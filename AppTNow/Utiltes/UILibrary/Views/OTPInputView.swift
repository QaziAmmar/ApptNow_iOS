//
//  OTPInputView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct OTPInputView: View {
    @Binding private var otp: String
    @FocusState private var isKeyboardShowing: Bool
    
    init(otp: Binding<String>) {
        self._otp = otp
    }
    
    var body: some View {
        VStack(spacing: 24) {
            otpTextfield()
        }
    }
    
    func otpTextfield() -> some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<6, id: \.self) { index in
                    otpTextBox(index)
                }
            }
            .background {
                TextField("", text: $otp.limit(6))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
        }
    }
    
    private func otpTextBox(_ index: Int) -> some View {
          let status = isKeyboardShowing && otp.count == index
          let _ = otp.count > index
          let borderColor = status ? Color.black : Color.gray
          let borderWidth: CGFloat = status ? 1.0 : 0.5
          let otpCharacter = otp.count > index ? String(otp[otp.index(otp.startIndex, offsetBy: index)]) : ""
          
          return ZStack {
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                  .fill(Color.color(.textFeildBackground))
              Text(otpCharacter)
          }
          .frame(width: 50, height: 50)
          .background(
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                  .stroke(borderColor, lineWidth: borderWidth)
                  .animation(.easeInOut(duration: 0.2), value: status)
          )
          .frame(maxWidth: .infinity)
      }
}

struct OTPInputView_Previews: PreviewProvider {
    static var previews: some View {
        OTPInputView(otp: .constant(""))
    }
}
