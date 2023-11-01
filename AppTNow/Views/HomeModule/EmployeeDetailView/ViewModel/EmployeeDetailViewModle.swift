//
//  EmployeeDetailViewModle.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 27/10/2023.
//

import Foundation

class EmployeeDetailViewModle: APPTNowBaseViewModel{
    
    @Published var appointmentMessage = ""
    @Published var selecteDate = Date()
    @Published var timeSlotes = [TimeSlot]()

}


extension EmployeeDetailViewModle: RequestManager {
    
    func getEmployeeSchedule(employeeId: String) async {
        
        let selectDateInString =  DateFormatter.dayString(from: selecteDate)
        let month: String = DateFormatter.monthName(from: selecteDate)
        let monthNumber = DateFormatter.monthNumber(from: month) ?? month
        let year: String = DateFormatter.yearString(from: selecteDate)
        
        showLoader = true
        
        let endPoint: HomeEndPoint = .getEmployeeSchedule(employee_id: employeeId, date: selectDateInString, month: monthNumber, year: year)
        let resulet = await sendApiRequest(request: endPoint, responseModel: GenericResponseModel<EmployeeScheduleModel>.self)
        showLoader = false
        switch resulet {
        case .success(let data):
            if let sechedulData: EmployeeScheduleModel = data.data {
                DispatchQueue.main.async {
                    self.timeSlotes = sechedulData.timeSlots
                }
                
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            showError(message: error.customMessage)
        }
    }
    
}

