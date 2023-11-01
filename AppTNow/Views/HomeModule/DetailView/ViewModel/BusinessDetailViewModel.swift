//
//  BusinessDetailViewModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 25/10/2023.
//

import Foundation

class BusinessDetailViewModel: APPTNowBaseViewModel {
    
//    Just for testing purpose
//    @Published var business: Business? = mockBusinessList.first!
//    For actual user
    @Published var business: Business?
    @Published var isBusinessSaved = false
    
    
}

//MAKR: Business
extension BusinessDetailViewModel {
 
    func getBusinessTimings() -> String{
        if let _ = business {
            
            if !(business?.businessTimings!.isEmpty)! {
                
                let startTime = DateManager.shared.convertTo12HourFormat(timeString: business?.businessTimings?.first?.startTime ?? "") ?? ""
                let endTime = DateManager.shared.convertTo12HourFormat(timeString: business?.businessTimings?.first?.endTime ?? "") ?? ""
                
                return startTime + " - " + endTime
                
            } else {
                return "N/A"
            }
            
        }
        
        return "N/A"
    }
    
}
 
// MAKR: Network manager function
extension BusinessDetailViewModel: RequestManager {

    
    @MainActor
    func businessDetail(businessId: String) async  {
        
        showLoader = true
        let request: HomeEndPoint = .businessDetails(business_id: businessId)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<Business>.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
                business = data.data!
                isBusinessSaved = business?.isSaved ?? false
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            self.showError(message: error.localizedDescription)
        }
    }
    
    @MainActor
    func writeReview(businessID: String, message: String, rating: String) async -> Bool {
        
        if message.isEmpty {
            showError(message: "please enter message")
            return false
        }
        
        showLoader = true
        let request: HomeEndPoint = .businessReview(business_id: businessID, review: message, rating: rating)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<Review>.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
                business?.reviews?.append(data.data!)
                return true
            } else {
                self.showError(message: data.message ?? "")
                return false
            }
        case .failure(let error):
            self.showError(message: error.localizedDescription)
            return false
        }
    }
    
    @MainActor
    func saveBusinessWith(businessID: String, status: String) async {
        
        showLoader = true
        let request: HomeEndPoint = .savedUnsavedBusiness(business_id: businessID, status: status)
        let result = await sendApiRequest(request: request, responseModel: GenericResponse.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false {
                
                if status == "0" {
                    self.business?.isSaved = false
                } else {
                    self.business?.isSaved = true
                }
            } else {
                self.business?.isSaved = false
//                self.showError(message: data.message ?? "")
            }
//            for publishing the changes.
            isBusinessSaved = self.business?.isSaved ?? false
        case .failure(let error):
            self.showError(message: error.localizedDescription)
            
        }
    }
    
    
}
