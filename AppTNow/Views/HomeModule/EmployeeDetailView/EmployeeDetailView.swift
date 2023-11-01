//
//  EmployeeDetailView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 27/10/2023.
//

import SwiftUI

struct EmployeeDetailView: AppTNowView {
    
    var employee: Employee
    @State private var appointmentMessage = ""
    @State private var isCalanderPresented = false
    

    @StateObject var viewModel = EmployeeDetailViewModle()
    @FocusState private var isMessageFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        
        .task {
            await viewModel.getEmployeeSchedule(employeeId: String(employee.id))
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
        .sheet(isPresented: $isCalanderPresented) {
            CalanderView(date: $viewModel.selecteDate, isCalanderPresented: $isCalanderPresented)
                .presentationDetents([.medium, .large])
                .onDisappear {
                    debugPrint("dismiss is called")
                }
        }
    }
}

// MARK: View Extesnion
extension EmployeeDetailView {
    
    
    private var loadView: some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack(alignment: .trailing) {
                NavBar(title: "Employee Details", action: {dismiss()})
                doneButton
            }
            
            userInfoView
            aboutView
            
            VStack(alignment: .center) {
                selecteDateView
                timeSlotView
            }
            
            Spacer()
            descriptionView
            bookAppointmentButton
            
            
        }.padding()
    }
    
    @ViewBuilder
    private var doneButton: some View {
            HStack {
                if isMessageFocused {
                    Button("Done") {
                        isMessageFocused = false
                    }.foregroundColor(.blue)
                }
            }
        }
    
    
    var userInfoView: some View {
        
        HStack(spacing: 10) {
            RectangleAysnImageView(url: employee.image,
                                   width: 36,
                                   height: 36)
            HStack(alignment: .top) {
                nameAndNumberView
                Spacer()
                RatingView(rating: employee.averageRating, textColor: .black)
            }
            
            
        }
    }

    
    var nameAndNumberView: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(employee.name)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
            
            
            Text(employee.phone)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(secondaryTextColor)
                .lineLimit(2)
        }
    }
    
//    About section
    
    var aboutView: some View {
        VStack(alignment: .leading){
            Text("About")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
            
            
            Text(employee.description)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(secondaryTextColor)
        }
    }
    
    
    var selecteDateView: some View {
        VStack(alignment: .leading,spacing: 10) {
            
            Button {
                isCalanderPresented.toggle()
            } label: {
                HStack{
                    Text("Select Date")
                        .font(AppTNowFont.medium.getFont(size: .h3))
                        .foregroundColor(textColor)
                    Spacer()
                    
                    Text("\(DateManager.shared.getStrDate(from: viewModel.selecteDate))")
                    Image(systemName: "chevron.down")
                }.font(AppTNowFont.medium.getFont(size: .h2))
                    .foregroundColor(secondaryTextColor)
            }
        }
    }
    
    
    var emptyViewForTimeSlots: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(ImageName.Home.profileLeave.rawValue)
                .frame(width: 150, height: 150)
            
            Text("No time slots available for selected date")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
        }
    }
    
    @ViewBuilder
    var timeSlotView: some View {

        if viewModel.timeSlotes.isEmpty {
            emptyViewForTimeSlots
                .padding(.top)
        } else {
            TimeSlotView(timeSlots: viewModel.timeSlotes)
        }
    }
    
    
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Message(Optional)")
                .font(AppTNowFont.medium.getFont(size: .h2))
                .foregroundColor(textColor)
            
            VStack {
                
                TextField("write something about service", text: $appointmentMessage,axis: .vertical)
                    .lineLimit(2...5)
                    .font(.system(size: 13))
                    .focused($isMessageFocused)
                Spacer()
                
            }   .padding(15)
                .frame(height: 110)
                .background(backgroundColor.opacity(0.5))
                .cornerRadius(10)
        }
    }
    
    
    private var bookAppointmentButton: some View {
        customButton(
            title: "Book Appointment",
            action: {
                debugPrint("did tap save bookAppointmentButton")
            })
    }
    
}

struct EmployeeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetailView(employee: mockEmployee.first!)
    }
}
