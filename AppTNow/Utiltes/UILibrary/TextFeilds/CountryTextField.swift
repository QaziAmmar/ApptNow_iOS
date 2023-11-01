//
//  CountryTextField.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//
import SwiftUI

struct CountryTextField: View {
    @Binding var countryCode: String
    @Binding var phoneNumber: String
    @Binding var startTimer: Bool
    let countryCodes: [String] = ["+1", "+44", "+91", "+86", "+92"]
    
    var body: some View {
        HStack {
           
            Picker("",selection: $countryCode) {
                    ForEach(countryCodes, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(.black)
                
            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
            
            Spacer()
            
            if startTimer {
                HStack {
                    Spacer()
                    CountDownView(startTimer: $startTimer)
                }
            }
        }
        .padding(15)
        .background(Color.color(.textFeildBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05),radius: 3,x: 0,y: 4)
        .foregroundColor(Color.black)
        .frame(height: 56)
    }
}

struct CountryTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {

            CountryTextField( countryCode: .constant(""), phoneNumber: .constant("3217460875"), startTimer: .constant(false) )
            CountryTextField(countryCode: .constant("+1"), phoneNumber: .constant("3217460875"), startTimer: .constant(true) )
            
        }
    }
}

