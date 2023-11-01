//
//  HorizontalCategorySelectionView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 24/10/2023.
//

import SwiftUI

struct HorizontalCategorySelectionView: AppTNowView {
    
    var categories: [BusinessCategory]
    @Binding var selectedIndex: Int
    
    var body: some View {
        loadView()
    }
}

extension HorizontalCategorySelectionView {
    
    func loadView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {

                ForEach(categories) { category in

                    VStack(alignment: .leading, spacing: 0) {
                        Text(category.name)
                            .foregroundColor(selectedIndex == category.id ?  .white : textColor.opacity(0.7))
                            .font(AppTNowFont.regular.getFont(size: .h3))
                            .padding([.vertical], 8)
                            .padding([.horizontal], 12)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(selectedIndex == category.id ?  appColor : .gray.opacity(0.2))
                    )
                    .onTapGesture {
                        selectedIndex = category.id
                    }

                }
            }
        }
    }
    
}



struct HorizontalCategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCategorySelectionView(categories: mockBusinessCategories, selectedIndex: .constant(1))
    }
}





