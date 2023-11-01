//
//  HorizontalServiceSelctionView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 26/10/2023.
//

import SwiftUI

struct HorizontalServiceSelctionView: AppTNowView {
    var services: [Service]
    @Binding var selectedIndex: Int
    
    var body: some View {
        loadView()
    }
}

extension HorizontalServiceSelctionView {
    
    func loadView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {

                ForEach(services) { service in

                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            CircularAsyncImageView(url: service.image, size: 30)
                            Text(service.name)
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: false)
                                .font(AppTNowFont.regular.getFont(size: .h1))
                        }.padding(8)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(selectedIndex == service.id ?  appColor : .gray.opacity(0.2))
                    )
                    .onTapGesture {
                        selectedIndex = service.id
                    }
                }
            }
        }
    }
    
}



struct HorizontalServiceSelctionView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalServiceSelctionView(services: mockServiceForBusiness, selectedIndex: .constant(1))
    }
}
