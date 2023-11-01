//
//  StatusManager.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 10/10/2023.
//

import Foundation
import SwiftUI

class StatusManager {
//    0 = Cancel / Rejected
//    1 = Completed
//    2 = User Requested / Pending
//    3 = Employee Accepted
//    4 = Appointment start/current
    
   class func getStatusTextAndColorFrom(status: String) -> (String, Color) {
        if status == "0" {
            return ("Cancelled", .red)
        } else if status == "1" {
            return ("Completed", .green)
        } else if status == "3" {
            return ("In Progress", .color(.mainColor).opacity(0.7))
        } else {
            return ("Pending", .yellow)
        }
    }
    
}
