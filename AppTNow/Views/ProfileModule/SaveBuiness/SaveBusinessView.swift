//
//  SaveBusinessView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 13/08/2023.
//

import SwiftUI

struct SaveBusinessView: AppTNowView {
    @StateObject private var viewModel: SaveBusinessViewModel = SaveBusinessViewModel()
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $viewModel.showLoader)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(viewModel.errorMessage))
        })
    }
}

extension SaveBusinessView {
    private var loadView: some View {
        VStack(spacing: 30) {
            topNavigation
            Spacer()
            
            if viewModel.allBusiness.isEmpty {
                EmptyView()
            }else {
                businessView
            }
            Spacer()
            
        }.padding([.leading,.trailing], 10)
         .task {
            await viewModel.getAllbusniess()
        }
    }
    
    private var topNavigation: some View {
        NavBar(title: "Saved Business Stores", action: {dismiss()})
    }
    
    private var businessView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.allBusiness) { busines in
                    BusinessCellView(business: busines)
                }
            }
        }
    }
}
#if DEBUG
struct SaveBusinessView_preview: PreviewProvider {
    static var previews: some View {
        SaveBusinessView()
        EmptyView()
    }
}
#endif

struct EmptyView: AppTNowView {
    var body: some View {
        VStack {
            Image(ImageName.Common.emptyView.rawValue)
            Text("No saved business available")
                .font(AppTNowFont.medium.getFont(size: .h3))
                .foregroundColor(textColor)
        }
    }
}

class SaveBusinessViewModel: APPTNowBaseViewModel {
    @Published var allBusiness: [Business] = [Business]()
}
extension SaveBusinessViewModel: RequestManager {
    @MainActor
    func getAllbusniess() async {
        showLoader = true
        let endPoint: SettingEndPoints = .saveBusiness
        let resulet = await sendApiRequest(request: endPoint, responseModel: GenericResponseModel<[Business]>.self)
        showLoader = false
        switch resulet {
        case .success(let data):
            if let business =  data.data {
                allBusiness = business
            } else {
                self.showError(message: data.message ?? "")
            }
        case .failure(let error):
            showError(message: error.customMessage)
        }
    }
}
