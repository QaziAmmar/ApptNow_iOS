//
//  TimeSlotView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 01/11/2023.
//

import SwiftUI
import SwiftUI





struct TimeSlotView: AppTNowView {
    let timeSlots: [TimeSlot]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 16) {
                ForEach(0..<timeSlots.count, id: \.self) { index in
                    if index % 2 == 0 {
                        HStack(spacing: 20) {
                            let timeSlot1 = timeSlots[index]
                            let timeSlot2 = (index + 1 < timeSlots.count) ? timeSlots[index + 1] : nil
                            
                            TimeSlotButton(timeSlot: timeSlot1)
                                
                            if let timeSlot2 = timeSlot2 {
                                TimeSlotButton(timeSlot: timeSlot2)

                            }
                        }
                    }
                }
            }
        }.padding(.bottom, 5)
    }
    
    @ViewBuilder
    private func TimeSlotButton(timeSlot: TimeSlot) -> some View {
        HStack {
            let compTimeSlot = timeSlot.startTime + " - " + timeSlot.endTime
            let status = timeSlot.status
            Image(systemName: "clock.fill")
                .foregroundColor(status == 1 ? .white : secondaryTextColor)
            Text(compTimeSlot)
                .foregroundColor(status == 1 ? .white : textColor)
        }
        .font(AppTNowFont.regular.getFont(size: .h1))
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(timeSlot.status == 1  ? appColor:  backgroundColor)
        .cornerRadius(5)
        
    }
}

#Preview {
    TimeSlotView(timeSlots: mockTimeSlots)
}
