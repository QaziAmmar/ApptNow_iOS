//
//  ApptHistoryViewModel.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 09/10/2023.
//

import Foundation

import SwiftUI

final class ApptHistoryViewModel: APPTNowBaseViewModel {
    
    @Published var segmentationSelection: AppointmentTypes = .all
    @Published var allAppointments: [Appointment] = []
    @Published var filteredAppointment: [Appointment] = []
    
}

// MARK: Custom Function Ex
extension ApptHistoryViewModel {
    
    //    0-rejected /cancelled
    //    1-completed
    //    2-request pending for employee accept or reject
    //    3-employee accept appointment and then pending
    
    func filterAppointmenst(selection: AppointmentTypes) {
        switch selection {
        case .all:
            filteredAppointment = allAppointments
        case .upComing:
            filteredAppointment = allAppointments.filter { $0.status == "2" ||  $0.status == "2" }
        case .previous:
            filteredAppointment = allAppointments.filter { $0.status == "0" ||  $0.status == "1"}
        }
    }
    
    func sortAppt(appointments: [Appointment]) -> [Appointment] {
        var sortedAppts = appointments
        sortedAppts.sort { (appointment1, appointment2) -> Bool in
            // Convert appointmentDate strings to Date objects
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date1 = dateFormatter.date(from: appointment1.appointmentDate),
               let date2 = dateFormatter.date(from: appointment2.appointmentDate) {
                // Compare the appointment dates
                return date1 > date2
            } else {
                // Handle date parsing error
                return false
            }
        }
        
        return sortedAppts
    }
    
}

// MARK: Network Mangager Extesnsion
extension ApptHistoryViewModel: RequestManager {
    @MainActor
    func getApptHistoryList() async {
        
        showLoader = true
        let endPoint: ApptHistoryEndPoints = .getAppointments
        let result = await sendApiRequest(request: endPoint, responseModel:GenericHistoryModel<[Appointment]>.self)
        showLoader = false
        
        switch result {
            
        case .success(let data):
            
            if data.status ?? false {
                allAppointments = data.all_appointment ?? []
                allAppointments = sortAppt(appointments: allAppointments)
                filteredAppointment = allAppointments
            }
            
        case .failure(let error):
            debugPrint(error.customMessage)
            self.showError(message: error.customMessage)
        }
        
    }
    
    @MainActor
    func startAppt(appt: Appointment) async -> Bool {
        
        showLoader = true
//
        let endPoint: ApptHistoryEndPoints = .startAppointment(user_id: appt.userID, appointment_id: String(appt.id), start_time: appt.appointmentStart, end_time: appt.appointmentEnd)
        let result = await sendApiRequest(request: endPoint, responseModel: GenericResponse.self)
        showLoader = false
        
        switch result {
            
        case .success(let data):
            
            if data.status ?? false {
                return true
            }
            return false
            
        case .failure(let error):
            debugPrint(error.customMessage)
            self.showError(message: error.customMessage)
            return false
        }
        
    }
    
    @MainActor
    func endAppt(appt: Appointment) async -> Bool {
        
        showLoader = true
//
        let endPoint: ApptHistoryEndPoints = .endAppointment(user_id: appt.userID, appointment_id: String(appt.id))
        let result = await sendApiRequest(request: endPoint, responseModel: GenericResponse.self)
        showLoader = false
        
        switch result {
            
        case .success(let data):
            
            if data.status ?? false {
                return true
            }
            return false
            
        case .failure(let error):
            debugPrint(error.customMessage)
            self.showError(message: error.customMessage)
            return false
        }
        
    }

}
