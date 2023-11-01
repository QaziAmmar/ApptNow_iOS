//
//  HomeViewModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 24/10/2023.
//

import Foundation


class HomeViewModel: APPTNowBaseViewModel {
    
    @Published var searchText: String = ""
    @Published var businesses = [Business]()
    @Published var businessCategoriesList: [BusinessCategory] = []
    
    @Published var selectedBusinessCategoryID = 0


}

extension HomeViewModel {
    
    func addBusinessCategories(categories: [BusinessCategory] ) {
        businessCategoriesList.removeAll()
        businessCategoriesList.append(BusinessCategory(id: 0, name: "All Businesses", created_at: "02/10/23 18:03", updated_at: "02/10/23 18:03"))
        businessCategoriesList += categories
    }
    
    func fetchBusinessListWithCategory() async {
        if selectedBusinessCategoryID == 0 {
            await fetchBusinessListApi(business_category: "")
        }
        await fetchBusinessListApi(business_category: String(selectedBusinessCategoryID))
    }
    
    
}
 
// MAKR: Network manager function
extension HomeViewModel: RequestManager {

    
    @MainActor
    func fetchBusinessCategoriesAPI() async  {
        showLoader = true
        let request: HomeEndPoint = .businessCategory
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<[BusinessCategory]>.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
                self.addBusinessCategories(categories: data.data ?? [])
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            self.showError(message: error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchBusinessListApi(business_category: String) async  {
        businesses.removeAll()
        showLoader = true
        let request: HomeEndPoint = .home(search: searchText, business_category: business_category)
        let result = await sendApiRequest(request: request, responseModel: GenericResponseModel<BusinessList>.self)
        showLoader = false
        switch result {
        case .success(let data):
            if data.status ?? false{
                businesses = data.data?.businessInRadius ?? []
            } else {
//                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            self.showError(message: error.localizedDescription)
        }
    }
    
}
