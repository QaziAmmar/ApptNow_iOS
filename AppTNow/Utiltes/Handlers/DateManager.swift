//
//  DateManager.swift
//  AppTNowEmplyee
//
//  Created by Qazi Ammar Arshad on 11/10/2023.
//

import Foundation

class DateManager {
    
    static let shared = DateManager()
    
    class func generateApptDurationFrom(appt: Appointment) -> String{
        
        return "\(String(appt.appointmentStart.prefix(5))) - \(String(appt.appointmentEnd.prefix(5)))"
        
    }
    
    class func isAppointmentStarted(appt: Appointment) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let appointmentDateTime = dateFormatter.date(from: "\(appt.appointmentDate) \(appt.appointmentStart)") {
            let currentDateTime = Date() // Get the current date and time
            
            return currentDateTime >= appointmentDateTime
        }
        
        return false // Invalid date or time format
    }
    
    func getDateMonthFrom(inputDateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set the locale to ensure consistent date formatting
        
        if let date = dateFormatter.date(from: inputDateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "d MMMM"
            outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let outputDateString = outputDateFormatter.string(from: date)
            return outputDateString
        } else {
            debugPrint("Invalid date format")
            return "NA"
            
        }
        
    }
    
    func getMonthDateyearFrom(inputDateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set the locale to ensure consistent date formatting
        
        if let date = dateFormatter.date(from: inputDateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "MMM d, yyyy"
            outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let outputDateString = outputDateFormatter.string(from: date)
            return outputDateString
        }
        debugPrint("Invalide date String")
        return "NA" // Invalid date format
    }
    
    func getStrDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" // You can customize the date format as needed
        return dateFormatter.string(from: date)
    }
    
    func convertTo12HourFormat(timeString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Input format for 24-hour time
        
        if let date = dateFormatter.date(from: timeString) {
            dateFormatter.dateFormat = "h:mm a" // Output format for 12-hour time
            return dateFormatter.string(from: date)
        } else {
            return nil // Invalid input format
        }
    }
    
    func startAndEndTime(startTime: String?, endTime: String?) -> String {
        if let startTime = startTime, let endTime = endTime {
            let startTime12Hr = convertTo12HourFormat(timeString: startTime) ?? ""
            let endTime12Hr = convertTo12HourFormat(timeString: endTime) ?? ""
            return startTime12Hr + " - " + endTime12Hr
        }
        
        return "N/A"
    }
    
}
