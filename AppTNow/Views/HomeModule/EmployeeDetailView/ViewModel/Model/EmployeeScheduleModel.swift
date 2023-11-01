//
//  TimeSlotModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 01/11/2023.
//

import Foundation


// MARK: - DataClass
struct EmployeeScheduleModel: Codable {
//    let employee: Employee
//    let serviceName, serviceID, businessID, businessName: String
//    let averageRating: String?
//    let ratingsCount: Int
    let timeSlots: [TimeSlot]
//    let leaveStatus: Bool
//    let serviceCharges, paymentBeforeAfter, userReward: String

    enum CodingKeys: String, CodingKey {
//        case employee
//        case serviceName = "service_name"
//        case serviceID = "service_id"
//        case businessID = "business_id"
//        case businessName = "business_name"
//        case averageRating = "average_rating"
//        case ratingsCount = "ratings_count"
        case timeSlots = "time_slots"
//        case leaveStatus = "leave_status"
//        case serviceCharges = "service_charges"
//        case paymentBeforeAfter
//        case userReward = "user_reward"
    }
}


// MARK: - TimeSlot
struct TimeSlot: Codable, Identifiable {
    let id: Int
    let employeeID, appointmentID, date, startTime: String
    let endTime: String
    let status: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case employeeID = "employee_id"
        case appointmentID = "appointment_id"
        case date
        case startTime = "start_time"
        case endTime = "end_time"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

let mockTimeSlots = [
    TimeSlot(
        id: 32,
        employeeID: "1",
        appointmentID: "38",
        date: "2023-11-10",
        startTime: "16:00:00",
        endTime: "16:30:00",
        status: 2,
        createdAt: "01/11/23 06:28",
        updatedAt: "01/11/23 06:28"
    ),
    TimeSlot(
        id: 29,
        employeeID: "1",
        appointmentID: "36",
        date: "2023-11-10",
        startTime: "15:00:00",
        endTime: "15:30:00",
        status: 1,
        createdAt: "31/10/23 09:37",
        updatedAt: "31/10/23 09:37"
    ),
    TimeSlot(
        id: 30,
        employeeID: "1",
        appointmentID: "37",
        date: "2023-11-10",
        startTime: "15:31:00",
        endTime: "16:00:00",
        status: 1,
        createdAt: "31/10/23 13:08",
        updatedAt: "31/10/23 13:08"
    )
]
