//
//  AppointmentHistoryView.swift
//  AppTNowEmplyee
//
//  Created by Qazi Mudassar on 02/09/2023.
//

import SwiftUI

enum AppointmentTypes: String, CaseIterable {
    case all = "All"
    case upComing = "Upcoming"
    case previous = "Previous"
}

struct ApptHistoryView: AppTNowView {
    @StateObject var viewModel = ApptHistoryViewModel()
    
    var body: some View {
        loadView()
            .onReceive(viewModel.$segmentationSelection) { newValue in
                viewModel.filterAppointmenst(selection: newValue)
            }
            .task {
                if viewModel.allAppointments.isEmpty {
                    await viewModel.getApptHistoryList()
                }
            }
    }
}

// MARK: View Extension
extension ApptHistoryView {
    
    func loadView() -> some View {
        VStack(spacing: 30) {
  
            Text("Appointment History")
                .font(
                    Font.custom("Sharp Sans", size: 24)
                        .weight(.semibold)
                )
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
            
            SegmentedPickerView(selectedOption: $viewModel.segmentationSelection)
                .padding(.bottom,20)
            
            if viewModel.filteredAppointment.isEmpty {
                emptyListView
            } else {
                ScrollView {
                    ForEach(Array(viewModel.filteredAppointment.enumerated()), id: \.element.id) { index, element in
                        LazyVStack {
                            NavigationLink(destination:
                                            ApptDetailView(appt: $viewModel.filteredAppointment[index], viewModel: viewModel)
                                .hideNavigationBar
                            ) {
                                ApptHistoryCell(appt: viewModel.filteredAppointment[index])
                            }
                        }
                    }
                }
            }

        }.padding(15)
    }
    
    @ViewBuilder
    var emptyListView: some View {
        VStack {
            Spacer()
            Image(ImageName.Common.emptyView.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("No Appointment")
                .font(
                    Font.custom("Sharp Sans", size: 16)
                        .weight(.medium)
                )
                .foregroundColor(textColor)
            
            Spacer()
        }
       
    }
    
}


#if DEBUG
struct ApptHistoryView_Perview: PreviewProvider {
    static var previews: some View {
        ApptHistoryView()
    }
}
#endif

private struct SegmentedPickerView: View {
    @Binding var selectedOption: AppointmentTypes
    
    init(selectedOption: Binding<AppointmentTypes>) {
        self._selectedOption = selectedOption
        UISegmentedControl.appearance().selectedSegmentTintColor = AppTNowColor.mainColor.color
        UISegmentedControl.appearance()
            .setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UISegmentedControl.appearance()
            .setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        Picker("", selection: $selectedOption) {
            ForEach(AppointmentTypes.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

