//
//  HomeEndPoint.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 25/10/2023.
//

import Foundation


enum HomeEndPoint {
    case businessCategory
    case home(search: String, business_category: String)
    case businessDetails(business_id: String)
    case businessReview(business_id: String, review : String, rating: String)
    case savedUnsavedBusiness(business_id: String, status: String)
    case employeeAgainstService(service_id: String)
    case getEmployeeSchedule(employee_id: String, date: String, month: String, year: String)
    
}
extension HomeEndPoint: Request {
    
    private var baseURL: String {
        return AppUrl.BASEURL
    }
    
    var url: URL {
        switch self {
        case .businessCategory:
            return URL(string: baseURL + "business_subCategory").orEmpty
        case .home:
            return URL(string: baseURL + "home").orEmpty
        case .businessDetails:
            return URL(string: baseURL + "business_details").orEmpty
        case .businessReview:
            return URL(string: baseURL + "business_review").orEmpty
        case .savedUnsavedBusiness:
            return URL(string: baseURL + "saved_unsaved_business").orEmpty
        case .employeeAgainstService:
            return URL(string: baseURL + "employee_against_service").orEmpty
        case .getEmployeeSchedule:
            return URL(string: baseURL + "get_employee_schedule").orEmpty
        }
    }
    
    var methodType: HttpMethod {
        switch self {
        case .businessCategory:
            return .get([])
            
        case .home(let search, let business_category):
            return .post(
                [
                    "user_id" :  (UserManager.shared.get()?.id ?? 0),
                    "search" : search,
                    "business_category" : business_category
                ]
            )
            
        case .businessDetails(let business_id):
            return .post(
                [
                    "user_id" :  (UserManager.shared.get()?.id ?? 0),
                    "business_id": business_id,
                ]
            )
            
        case .businessReview(let business_id, let review, let rating):
            return .post(
                [
                    "user_id" :  String((UserManager.shared.get()?.id ?? 0)),
                    "business_id" : business_id,
                    "review" : review,
                    "rating": rating
                ]
            )
            
        case .savedUnsavedBusiness(let business_id, let status):
            return .post(
                [
                    "user_id" :  String((UserManager.shared.get()?.id ?? 0)),
                    "business_id" : business_id,
                    "status" : status,
                ]
            )
            
        case .employeeAgainstService(let service_id):
            return .post(
                [
                    "service_id": service_id
                ]
            )
            
        case .getEmployeeSchedule(let employee_id, let date, let month, let year):
            return .post(
                [
                    "employee_id": employee_id,
                    "date": date,
                    "month": month,
                    "year": year
                ]
            )
        }
        
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(UserManager.shared.get()?.token ?? "")",
                "Content-Type": "application/json;charset=utf-8"]
    }
}
