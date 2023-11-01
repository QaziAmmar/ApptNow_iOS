//
//  GenricModel.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 30/07/2023.
//

import Foundation

struct GenricModel: Decodable {
    var statusCode: Int?
    var message: String?
    var success: Bool?
}

struct GenericResponse: Decodable {
    var message: String?
    var status: Bool?
}

struct GenericResponseModel<T: Codable>: Codable {
    var message: String?
    var status: Bool?
    var data: T?
    let token: String?
}

struct GenericHistoryModel<T: Codable>: Codable {
    
    var status: Bool?
    var all_appointment: T?
    var today_appointments: T?
    var upcoming_appointments: T?
    var previous_appointments: T?

}

struct DayTiming {
    let day: String
    let timing: String
    
    static var dummyList: [DayTiming] = [.init(day: "Monday", timing: "09:00AM - 06:00PM"),
                                         .init(day: "Tuesday", timing: "09:00AM - 06:00PM"),
                                         .init(day: "wendensday", timing: "09:00AM - 06:00PM"),
                                         .init(day: "Thursday", timing: "09:00AM - 06:00PM"),
                                         .init(day: "Firday", timing: "09:00AM - 02:00PM"),
                                         .init(day: "Saturday", timing: "Off"),
                                         .init(day: "Sunday", timing: "Off")]
}

