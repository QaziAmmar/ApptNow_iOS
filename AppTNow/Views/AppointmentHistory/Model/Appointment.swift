//
//  Appointment.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 20/10/2023.
//

import Foundation

// MARK: - RequestAppointment
struct Appointment: Codable {
    let id: Int
    let userID, businessID, employeeID, serviceID: String
    let appointmentDate, appointmentStart, appointmentEnd, appointmentCode: String
    var status, createdAt, updatedAt: String
    let serviceName: String?  // Added parameter
    let serviceDuration: String?  // Added parameter
    let servicePrice: String?  // Added parameter
    let userReward, appointmentCancelReason: String?  // Added parameter
    let employee: User
    let appointmentMessage: AppointmentMessage?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case businessID = "business_id"
        case employeeID = "employee_id"
        case serviceID = "service_id"
        case appointmentDate = "appointment_date"
        case appointmentStart = "appointment_start"
        case appointmentEnd = "appointment_end"
        case appointmentCode = "appointment_code"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case serviceName = "service_name"  // Added key
        case serviceDuration = "service_duration"  // Added key
        case servicePrice = "service_price"  // Added key
        case employee
        case appointmentMessage = "appointment_message"
        case userReward = "user_reward"  // Added key
        case appointmentCancelReason = "appointment_cancel_reason"
    }
}

// MARK: - AppointmentMessage
struct AppointmentMessage: Codable {
    let id: Int
    let appointmentID: String
    let message: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case appointmentID = "appointment_id"
        case message
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
let mockAppointmentMessage = AppointmentMessage(id: 8, appointmentID: "15", message: "I need some informa", createdAt: "02/10/23  19:04 PM", updatedAt: "09/10/23  13:09 PM")


let MockApptRequestData = [Appointment(id: 1, userID: "1", businessID: "1", employeeID: "1", serviceID: "1", appointmentDate: "2023-10-12", appointmentStart: "10:00:00", appointmentEnd: "11:00:00", appointmentCode: "287058", status: "1", createdAt: "02/10/23 19:04", updatedAt: "09/10/23 12:12", serviceName: "Visa Counseling", serviceDuration: "60", servicePrice: "10", userReward: "10", appointmentCancelReason: "This is why your appointment is cancled", employee: MockUser, appointmentMessage: mockAppointmentMessage)]

//Appointment(id: 1, userID: "1", businessID: "1", employeeID: "1", serviceID: "1", appointmentDate: "2023-10-26", appointmentStart: "14:00:00", appointmentEnd: "14:30:00", appointmentCode: "287058", status: "2", createdAt: "09/10/23  13:09 PM", updatedAt: "09/10/23  13:09 PM", user: MockUser, appointmentMessage: )

