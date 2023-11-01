//
//  ServicesView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 26/10/2023.
//

import SwiftUI

struct ServicesListView: AppTNowView {
    
    var services: [Service] = []
    var isAvailableNowView = false
    @State private var isCallingFirstTime = true
    
    @StateObject var viewModel =  ServicesListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }.alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        }).onAppear{
            if isCallingFirstTime {
                viewModel.selectedServiceID = services.first?.id ?? 0
                viewModel.selectedService = services.first
                fetchEmployee()
                isCallingFirstTime.toggle()
            }
            
        }.onChange(of: viewModel.selectedServiceID, perform: { newValue in
            debugPrint("Appt: selected index \(newValue)")
            viewModel.selectedServiceID = newValue
            viewModel.selectedService = services.first(where: {$0.id == newValue})
            fetchEmployee()
        })
        
    }
    
    func fetchEmployee() {
        Task {
            await viewModel.getEmployeeAgainst()
        }
    }
}
// MARK: View extension

extension ServicesListView {
    
    @ViewBuilder
    private var loadView: some View {
        VStack(spacing: 20) {
            NavBar(title: "Get Service") {
                self.dismiss()
            }
            serviesListView
            serviceChargesView
            employeeList
        }.padding()
    }
    
    
    @ViewBuilder
    private var serviesListView: some View {
        
        HorizontalServiceSelctionView(services: services, selectedIndex: $viewModel.selectedServiceID)
    }
    
    @ViewBuilder
    private var serviceChargesView: some View {
        VStack {
            HStack {
                Text("Service Charges")
                    .font(AppTNowFont.medium.getFont(size: .h1))
                    .foregroundColor(textColor)
                
                Text(viewModel.selectedService?.paid == "0" ? "Unpaid" : "Paid")
                    .font(AppTNowFont.medium.getFont(size: .h2))
                    .foregroundColor(.red)
                
                Spacer()
                
                Text("Service Points")
                    .font(AppTNowFont.medium.getFont(size: .h1))
                    .foregroundColor(textColor)
                
                Text("\(viewModel.selectedService?.points ?? "")Pts")
                    .font(AppTNowFont.medium.getFont(size: .h2))
                    .foregroundColor(appColor)
                
            }
            bannerView
        }
    }
    
    @ViewBuilder
    private var bannerView: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.gray.opacity(0.2))
                .frame(height: 45)
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(appColor)
                    Image(ImageName.AppointmentHistory.clockwhite.rawValue)
                        .resizable()
                        .frame(width: 13, height: 13)
                }
                .padding(.leading)
                Text("Choose employee and get your service")
                    .font(AppTNowFont.regular.getFont(size: .h1))
                    .foregroundColor(.color(.primaryText))
                Spacer()
                
            }
        }
    }
    
    @ViewBuilder
    private var employeeList: some View {
        VStack {
            HStack {
                Text("Employees")
                    .font(AppTNowFont.medium.getFont(size: .h3))
                    .foregroundColor(textColor)
                
                Spacer()
                
                NavigationLink {
                    ServicesListView(viewModel: viewModel)
                } label: {
                    Text("Get Service now")
                        .font(AppTNowFont.medium.getFont(size: .h3))
                        .foregroundColor(appColor)
                }
                
            }
            
            ScrollView {
                if viewModel.employeeList.isEmpty {
                    EmptyListView(imageName: ImageName.Home.noEmployee.rawValue, descriptionText: "No Employees available against this service")
                        .padding(.top, 50)
                    
                } else {
                    VStack {

                        ForEach(viewModel.employeeList) { employee in
                            NavigationLink {
                                EmployeeDetailView(employee: employee)
                                    .hideNavigationBar
                            } label: {
                                EmployeeInfoCardView(employee: employee)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
}


struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesListView(services: mockServiceForBusiness)
    }
}
