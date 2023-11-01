//
//  ServicesViewModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 26/10/2023.
//

import Foundation

class ServicesListViewModel: APPTNowBaseViewModel {
    
    @Published var selectedServiceID = 0
    @Published var selectedService: Service?
    @Published var employeeList = [Employee]()

    
}


// MAKR: - Network manager extension
extension ServicesListViewModel: RequestManager {
    @MainActor
    func getEmployeeAgainst() async  {
        
        showLoader = true
        let request: HomeEndPoint = .employeeAgainstService(service_id: String(selectedService?.id ?? 0))
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<[Employee]>.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
                employeeList = data.data ?? []
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            self.showError(message: error.localizedDescription)
        }
    }
}

