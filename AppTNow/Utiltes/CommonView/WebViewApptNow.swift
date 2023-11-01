//
//  WebViewApptNow.swift
//  AppTNowEmplyee
//
//  Created by Qazi Mudassar on 02/09/2023.
//

import SwiftUI

struct WebViewApptNow: AppTNowView {
    let title: String
    let url: String
    @State private var isLoading = true
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            loadView
            LoaderView(isLoading: $isLoading)
        }
    }
    
    var loadView: some View {
        VStack(alignment: .leading) {
            NavBar(title: title, action: {dismiss()})
            WebView(url: url,isLoading: $isLoading)
        }.padding(10)
            .onAppear {
                isLoading = true
            }
    }
}
