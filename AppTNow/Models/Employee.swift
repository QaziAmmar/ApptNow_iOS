//
//  Employee.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 27/10/2023.
//

import Foundation

// MARK: - Datum
struct Employee: Codable, Identifiable {
    let id: Int
    let serviceID, name, email, password: String
    let image, phone: String
    let status: Int
    let deviceID, lat, longi: String
    let code: Int
    let description, openingTime, closingTime, offDays: String
    let createdAt, updatedAt, averageRating: String

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name, email, password, image, phone, status
        case deviceID = "device_id"
        case lat, longi, code, description
        case openingTime = "opening_time"
        case closingTime = "closing_time"
        case offDays = "off_days"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case averageRating = "average_rating"
    }
}


let mockEmployee: [Employee] = [
    Employee(
        id: 1,
        serviceID: "1",
        name: "Salman",
        email: "employe@gmail.com",
        password: "12345678@@",
        image: "employees_profile/1696271231_651b0b7fa5fb3.jpg",
        phone: "0321201999",
        status: 1,
        deviceID: "",
        lat: "",
        longi: "",
        code: 0,
        description: "I am a React Developer",
        openingTime: "09:00:00",
        closingTime: "18:00:00",
        offDays: "Saturday,Sunday",
        createdAt: "03/10/23 03:14",
        updatedAt: "03/10/23 03:27",
        averageRating: "5"
    ),
    Employee(
        id: 2,
        serviceID: "1",
        name: "Zain",
        email: "employe2@gmail.com",
        password: "12345678@@",
        image: "employees_profile/1696272026_651b0e9a34262.jpeg",
        phone: "+92444546864564",
        status: 1,
        deviceID: "0560d01fb818a418",
        lat: "",
        longi: "",
        code: 0,
        description: "I am Backend Developer",
        openingTime: "09:00:00",
        closingTime: "18:00:00",
        offDays: "Saturday,Sunday",
        createdAt: "03/10/23 03:16",
        updatedAt: "03/10/23 03:56",
        averageRating: "4"
    ),
    Employee(
        id: 4,
        serviceID: "1",
        name: "salman",
        email: "saim@gmail.com",
        password: "123456",
        image: "",
        phone: "+92444546864564",
        status: 1,
        deviceID: "",
        lat: "",
        longi: "",
        code: 0,
        description: "",
        openingTime: "09:00:00",
        closingTime: "18:00:00",
        offDays: "Saturday,Sunday",
        createdAt: "03/10/23 14:45",
        updatedAt: "03/10/23 16:36",
        averageRating: "0"
    ),
    Employee(
        id: 5,
        serviceID: "1",
        name: "Zain",
        email: "saim1@gmail.com",
        password: "123456",
        image: "",
        phone: "+92444546864564",
        status: 1,
        deviceID: "",
        lat: "",
        longi: "",
        code: 0,
        description: "",
        openingTime: "09:00:00",
        closingTime: "18:00:00",
        offDays: "Saturday,Sunday",
        createdAt: "03/10/23 19:45",
        updatedAt: "03/10/23 19:45",
        averageRating: "0"
    )
]

