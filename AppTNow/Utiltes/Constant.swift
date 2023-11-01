//
//  Constant.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 25/07/2023.
//

import Foundation
import SwiftUI

enum ImageName {
    enum Registration: String {
        case welcomeBackground
        case appointmentNow
        case wavingHand
        case hidePassword
        case showPasswod
        case google
        case apple
        case time
    }
    
    enum Setting: String {
        case lock
        case phone
        case letter
        case bookmark
        case map
        case bell
        case shield
        case document
        case login
        case userDelete
        case userBlue
        case reward
    }
    
    enum AppointmentHistory: String {
        case history
        case calendarIcon
        case clockIcon
        case phoneIcon
        case apptCategory
        case calanderWhite
        case clockwhite
    }
    
    enum Common: String {
        case arrowLeft
        case pencil
        case thumb
        case mapPin
        case emptyView
        case apptNowWelcome
        
        var thumbImage: Image {
            return Image(rawValue)
        }
    }
    
    enum Detail: String {
        case noCommont
        case like
        case unLike
    }
    
    enum Dummy: String {
        case detailDummy
    }
    
//    MAKR: Home Module
    
    enum Home: String {
        case location
        case shop
        case noEmployee
        case profileLeave
    }
    
    enum Notification: String {
        case acceptedLeave
        case appointmentRescheduled
        case rejectedLeave
        case todayAppointment
        case todayAppointmentR
        case noticationEmpty
    }
    
}

enum AppUrl {
    static var BASEURL = "https://appointment.ml-bench.com/public/api/"
    static var IMAGEURL = "https://appointment.ml-bench.com/public/storage/"
}
