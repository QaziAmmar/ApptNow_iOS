//
//  UpCommingHistoryCell.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 09/10/2023.
//

import SwiftUI

struct ApptHistoryCell: AppTNowView {
    
    var appt: Appointment
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 10) {
                    
                    RectangleAysnImageView(url: appt.employee.image,
                                           width: 45,
                                           height: 45)
                    nameAndNumberView
                    Spacer()
                    apptStatusView(status: appt.status)
                }
                
                Divider()
                
                    HStack {
                        
                        createImageWithText(img: ImageName.AppointmentHistory.calendarIcon.rawValue,
                                            text: DateManager.shared.getMonthDateyearFrom(inputDateString: appt.appointmentDate))
                        .frame(width: 110)
                        
                        createImageWithText(img: ImageName.AppointmentHistory.clockIcon.rawValue,
                                            text: DateManager.generateApptDurationFrom(appt: appt))
                        .frame(width: 100)
                        createImageWithText(img: ImageName.AppointmentHistory.apptCategory.rawValue, text: appt.serviceName ?? "")
                            
                    
                }
                
                
            }.padding(10)
        }
        .background(backgroundColor)
        .cornerRadius(10)
        
    }
}

private extension ApptHistoryCell {
    @ViewBuilder
    var nameAndNumberView: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(appt.employee.name)
                .font(AppTNowFont.medium.getFont(size: .h4))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
            
            Text(appt.employee.phone)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(secondaryTextColor)
        }
    }
    
    
    func apptStatusView(status: String) -> some View {
        
        VStack {
            
            Text(StatusManager.getStatusTextAndColorFrom(status: status).0)
                .foregroundColor(StatusManager.getStatusTextAndColorFrom(status: status).1)
                .font(AppTNowFont.medium.getFont(size: .h3))
        }.padding(.horizontal)
    }
    
    
    func createImageWithText(img: String, text: String) -> some View {
        HStack(spacing: 7) {
            Image(img)
                .resizable()
                .frame(width: 17, height: 17)
            
            Text(text)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(textColor)
                .lineLimit(2)
        }
    }
}

struct ApptHistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        ApptHistoryCell(appt: MockApptRequestData.first!)
    }
}



