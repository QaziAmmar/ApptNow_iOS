//
//  User.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 30/07/2023.
//

import Foundation


struct User: Codable {
    let id: Int
    var name, email, phone, image, code: String
    let status, latitude, longitude: String?
    let fCode, deviceID, gToken, fbToken: String?
    let aCode, createdAt, updatedAt: String?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image, status, latitude, longitude, code
        case fCode = "f_code"
        case deviceID = "device_id"
        case gToken = "g_token"
        case fbToken = "fb_token"
        case aCode = "a_code"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case token
    }
}

let MockUser = User(
    id: 7,
    name: "Qazi Ammar Arshad",
    email: "qaziammar.g@gmail.com",
    phone: "+923355300400",
    image: "users_profile/bKn7wXtoAzB5Hp8.png",
    code: "0",
    status: "1",
    latitude: "",
    longitude: "",
    fCode: "0560d01fb818a418",
    deviceID: "0560d01fb818a418",
    gToken: "",
    fbToken: "",
    aCode: "",
    createdAt: "09/10/23 11:34 AM",
    updatedAt: "09/10/23 11:48 AM",
    token: "181|B0Cdfdc60uw2iPX04l3zC9AkkrDe8av5ReGqon5Y"
)
