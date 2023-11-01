//
//  ApptDetailView.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 10/10/2023.
//

import SwiftUI

struct ApptDetailView: AppTNowView {
    
    @Binding var appt: Appointment
    @ObservedObject var viewModel: ApptHistoryViewModel
    @State var isApptStarted = false
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        loadView()
            .onAppear {
                isApptStarted = DateManager.isAppointmentStarted(appt: appt)
            }
            .padding()
    }
}

// MARK View Extension
extension ApptDetailView {
    func loadView() -> some View {
        VStack(alignment: .leading) {
            topNavBar()
                if appt.status == "0" {
                    cancelledBanner()
                }
            ScrollView {
                VStack(alignment: .leading) {
                    userInfoView
                    apptDetailView
                    apptMessage(title: "Message(Optional)", description: appt.appointmentMessage?.message ?? "N/A")
                    if let cancelMessage = appt.appointmentCancelReason {
                        apptMessage(title: "Reason for Cancellation", description: cancelMessage)
                    }

                }
            }

            Spacer()
            if !isApptStarted && appt.status == "2" {
                apptStartBanner()
            }
            bottomButtons()
        }
    }
    
    
    //    Navbar
    func topNavBar() -> some View {
        NavBarWithAppStatusText(title: "Appt Detail", rightText : StatusManager.getStatusTextAndColorFrom(status: appt.status).0, rightTextColor: StatusManager.getStatusTextAndColorFrom(status: appt.status).1, action: {
            dismiss()
        })
    }
    
    //    cancle banner
    func cancelledBanner() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.red.opacity(0.5), lineWidth: 1)
                .frame(height: 41)
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.red.opacity(0.2))
                .frame(height: 40)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.red)
                    Image(ImageName.AppointmentHistory.calanderWhite.rawValue)
                        .resizable()
                        .frame(width: 13, height: 13)
                }
                .padding(.leading)
                Text("Cancelled Because appointment time is over")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .foregroundColor(.color(.primaryText))
                Spacer()
            }
            
        }
    }
    
    //    user Info
    var userInfoView: some View {
        
        HStack {
            RectangleAysnImageView(url: appt.employee.image,
                                   width: 62,
                                   height: 62)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(appt.employee.name)
                    .font(AppTNowFont.medium.getFont(size: .h3))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                
                Text(appt.employee.email)
                    .font(AppTNowFont.regular.getFont(size: .h2))
                    .foregroundColor(secondaryTextColor)
                
                Text(appt.employee.phone)
                    .font(AppTNowFont.regular.getFont(size: .h2))
                    .foregroundColor(secondaryTextColor)
            }
            Spacer()
        }
    }
    
    var apptDetailView: some View {
        LazyVStack(spacing: 15) {
            apptInfoCell(cellName: "Appointment Date",
                         cellDetail: DateManager.shared.getDateMonthFrom(inputDateString: appt.appointmentDate))
            
            apptInfoCell(cellName: "Appointment Time", cellDetail: DateManager.generateApptDurationFrom(appt: appt))
            apptInfoCell(cellName: "Service", cellDetail: appt.serviceName ?? "NA")
            apptInfoCell(cellName: "Service Charges", cellDetail: "$\(appt.servicePrice ?? "NA")")
            apptInfoCell(cellName: "Reward Points", cellDetail: "\(appt.userReward ?? "NA") Pts")
            apptInfoCell(cellName: "Service Duration", cellDetail: "\(appt.serviceDuration ?? "NA") Min")
        }
    }
    
    func apptInfoCell(cellName: String, cellDetail: String) -> some View {
        HStack {
            Text(cellName)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(textColor)
            Spacer()
            Text(cellDetail)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
            
        }
    }
    
    func apptMessage(title: String, description: String) -> some View {
        VStack(alignment: .leading){
            Text(title)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
            Text(description)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(textColor)
        }.padding(.top, 10)
    }
    
    func apptStartBanner() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.gray.opacity(0.15))
                .frame(height: 42)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.color(.mainColor))
                    Image(ImageName.AppointmentHistory.clockwhite.rawValue)
                        .resizable()
                        .frame(width: 13, height: 13)
                }
                .padding(.leading)
                Text("You can only start the appointment on scheduled  time")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .foregroundColor(.color(.primaryText))
                Spacer()
            }
            
        }
    }
    
    
}

// MARK: Button Extension
extension ApptDetailView {
    //    ButtonView
    
    //    0-rejected /cancelled
    //    1-completed
    //    2-request pending for employee accept or reject
    //    3-employee accept appointment and then pending
    
    func bottomButtons() -> some View {
        
        if appt.status == "0" {
            //            cancled
            return AnyView(applyForRefendButton())
        } else if appt.status == "1" {
            //            Complete
            return AnyView(completeButton())
            
        } else if appt.status == "2" {
            //            read to start/ open
//            check time if not then disable the buttons
            if isApptStarted {
                return AnyView(readyToStartButton())
            } else {
                return AnyView(disableButton())
            }
            
        } else {
            return AnyView(inProgressStateButton())
        }
    }
    
    func readyToStartButton() -> some View {
        VStack(spacing: 5) {
            customButton(
                title: "Start Appointment",
                action: {
                    Task {
                        let apiResponse = await viewModel.startAppt(appt: appt)
                        if apiResponse {
                            appt.status = "3"
                        }
                    }
                })
            disableButton(title: "End Appointment", action: {
                debugPrint("Disable button")
            })
            
        }
    }
    func disableButton() -> some View {
        VStack(spacing: 5) {
            
            disableButton(title: "Start Appointment", action: {
                debugPrint("Disable button")
            })
            disableButton(title: "End Appointment", action: {
                debugPrint("Disable button")
            })
            
        }
    }
    func inProgressStateButton() -> some View {
        VStack(spacing: 5) {
            
            disableButton(title: "Start Appointment", action: {
                debugPrint("Disable button")
            })
            
            customButton(
                title: "End Appointment",
                backgroundColor: .red,
                action: {
                    Task {
                        let apiResponse = await viewModel.endAppt(appt: appt)
                        if apiResponse {
                            appt.status = "1"
                        }
                    }
                })
            
        }
    }
    
    func completeButton() -> some View {
        VStack(spacing: 5) {
            
            customButton(
                title: "Employee Tip",
                backgroundColor: .white,
                action: {
                    Task {
//                        let apiResponse = await viewModel.endAppt(appt: appt)
//                        if apiResponse {
//                            appt.status = "1"
//                        }
                    }
                })
            customButton(
                title: "Rate This Employee",
                action: {
                    Task {
//                        let apiResponse = await viewModel.endAppt(appt: appt)
//                        if apiResponse {
//                            appt.status = "1"
//                        }
                    }
                })
            
            
        }
    }
    
    func applyForRefendButton() -> some View {
        VStack(spacing: 5) {
            
            customButton(
                title: "Apply For Refund",
                action: {
                    Task {
//                        let apiResponse = await viewModel.endAppt(appt: appt)
//                        if apiResponse {
//                            appt.status = "1"
//                        }
                    }
                })

        }
    }
}



struct ApptDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApptDetailView(appt: .constant(MockApptRequestData.first!), viewModel: ApptHistoryViewModel())
    }
}
