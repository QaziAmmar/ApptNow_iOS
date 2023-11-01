//
//  NotificationModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 24/10/2023.
//

import Foundation

struct NotificatioModel: Codable {
    let id: Int
    let employeeID, message, header: String
    let createdAt, updatedAt: String
    let status: String
    
    var icon: String {
        switch status {
        case "3":
            return ImageName.Notification.todayAppointment.rawValue
        case "0":
            return ImageName.Notification.rejectedLeave.rawValue
        case "2":
            return ImageName.Notification.todayAppointmentR.rawValue
        case "4":
            return ImageName.Notification.appointmentRescheduled.rawValue
        case "1":
            return ImageName.Notification.acceptedLeave.rawValue
        default:
            return ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeID = "employee_id"
        case message, header, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
