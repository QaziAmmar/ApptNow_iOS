//
//  DateFormattorEx.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 01/11/2023.
//

import Foundation


extension DateFormatter {
    static func dayString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    static func monthString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date)
    }
    
    static func yearString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func monthName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }
    
    static func monthNumber(from monthName: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        if let date = dateFormatter.date(from: monthName) {
            let calendar = Calendar.current
            let monthNumber = calendar.component(.month, from: date)
            return String(monthNumber)
        } else {
            return nil
        }
    }
    
    static func numberOfDaysInMonth(monthName: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        if let date = dateFormatter.date(from: monthName) {
            let calendar = Calendar.current
            let range = calendar.range(of: .day, in: .month, for: date)
            return range?.count
        } else {
            return nil // Invalid month name
        }
    }
    
}
