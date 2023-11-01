//
//  EmployeeInfoCardView.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 27/10/2023.
//

import SwiftUI

struct EmployeeInfoCardView: AppTNowView {
    var employee: Employee
    
    var body: some View {
        VStack {
            VStack() {
                HStack(spacing: 10) {
                    
                    RectangleAysnImageView(url: employee.image,
                                           width: 90,
                                           height: 90)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            nameAndNumberView
                            Spacer()
                            RatingView(rating: employee.averageRating, textColor: .black)
                        }
                        scheduleButton
                    }
                }
                
            }.padding(10)
        }.frame(height: 110)
            .background(backgroundColor)
            .cornerRadius(10)
        
    }
}

private extension EmployeeInfoCardView {
    @ViewBuilder
    var nameAndNumberView: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(employee.name)
                .font(AppTNowFont.medium.getFont(size: .h3))
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
            
            
            Text(employee.description)
                .font(AppTNowFont.regular.getFont(size: .h1))
                .foregroundColor(secondaryTextColor)
            
                .lineLimit(2)
        }
    }
    
    @ViewBuilder
    private var scheduleButton: some View {
        Text("Set Schedule")
            .font(AppTNowFont.medium.getFont(size: .h2))
            .multilineTextAlignment(.center)
            .foregroundColor(appColor)
        
    }

    
}

struct EmployeeInfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeInfoCardView(employee: mockEmployee.first!)
    }
}


