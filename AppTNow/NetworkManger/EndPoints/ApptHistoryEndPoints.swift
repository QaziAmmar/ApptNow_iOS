//
//  ApptHistoryEndPoints.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 09/10/2023.
//

import Foundation


enum ApptHistoryEndPoints {
    case getAppointments
    case startAppointment(user_id: String, appointment_id: String, start_time: String, end_time: String)
    case endAppointment(user_id: String, appointment_id: String)
    
}
extension ApptHistoryEndPoints: Request {
    
    private var baseURL: String {
        return AppUrl.BASEURL
    }
    
    var url: URL {
        switch self {
        case .getAppointments:
            return URL(string: baseURL + "get_appointments").orEmpty
        case .startAppointment:
            return URL(string: baseURL + "employee_start_appointment").orEmpty
        case .endAppointment:
            return URL(string: baseURL + "employee_end_appointment").orEmpty
        }
    }
    
    var methodType: HttpMethod {
        switch self {
        case .getAppointments:
            return .get(
                [
                    URLQueryItem(
                        name: "user_id",
                        value: "\(UserManager.shared.get()?.id ?? 0)")
                ]
            )
        case .startAppointment(let user_id, let appointment_id, let start_time, let end_time):
            return .post(
                [
                    "user_id": user_id,
                    "appointment_id": appointment_id,
                    "employee_id": "\(UserManager.shared.get()?.id ?? 0)",
                    "start_time": start_time,
                     "end_time": end_time
                ]
            )
            
        case .endAppointment(let user_id, let appointment_id):
            return .post(
                [
                    "user_id": user_id,
                    "appointment_id": appointment_id,
                    "employee_id": "\(UserManager.shared.get()?.id ?? 0)",
                ]
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(UserManager.shared.get()?.token ?? "")",
                "Content-Type": "application/json;charset=utf-8"]
    }
}
