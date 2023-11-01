//
//  CalanderView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 01/11/2023.
//

import SwiftUI

struct CalanderView: View {
    
    
    @Binding var date: Date
    @Binding var isCalanderPresented: Bool

    var body: some View {
        loadView()
    }
    
    func loadView() -> some View {
        VStack(alignment: .trailing) {
            
            Button {
                isCalanderPresented.toggle()
            } label: {
                Text("Done")
                    .font(.system(size: 16, weight: .semibold))
            }.padding()

            DatePicker("", selection: $date, in: Date()..., displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
            
        }
    }
}


#Preview {
    CalanderView(date: .constant(Date()), isCalanderPresented: .constant(false))
}
