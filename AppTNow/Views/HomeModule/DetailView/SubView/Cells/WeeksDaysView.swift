//
//  WeeksDaysView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

struct WeeksDaysView: AppTNowView {
    
    let daysTimings: [BusinessTiming]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Business timing")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
                .padding(.bottom, 13)
            
            ForEach(daysTimings, id: \.day) { dayTiming in
                HStack {
                    Text(dayTiming.day)
                        .font(AppTNowFont.medium.getFont(size: .h2))
                        .foregroundColor(textColor)
                    
                    Spacer ()
                    
                    Text(DateManager.shared.startAndEndTime(startTime: dayTiming.startTime, endTime: dayTiming.endTime))
                        .font(AppTNowFont.regular.getFont(size: .h1))
                        .foregroundColor(secondaryTextColor)
                    
                }
            }
        }
    }
}
#if DEBUG
struct WeeksDaysView_Previews: PreviewProvider {
    static var previews: some View {
        WeeksDaysView(daysTimings: (mockBusinessList.first?.businessTimings)!)
    }
}
#endif
