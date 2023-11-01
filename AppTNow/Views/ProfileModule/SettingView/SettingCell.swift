//
//  SettingCell.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 06/08/2023.
//

import SwiftUI

struct SettingCell: AppTNowView {
    let setting: SettingSubModel
    let deleteUser: () -> ()
    
    @State private var isToggelBtnPressed: Bool = true
    var body: some View {
        if let navigationView =  setting.destination {
            loadView
                .navigate(to: navigationView)
        } else {
            loadView
        }
    }
}

private extension SettingCell {
    
    var loadView: some View {
        VStack(spacing: 5) {
            HStack(spacing: 13) {
                circleView
                title
                Spacer()
                toggleBtn
                
            }
            dividerView
        }.contentShape(Rectangle())
    }
    
    var circleView: some View {
        Circle()
            .foregroundColor(setting.title == "Delete Account" ? deleteColor : backgroundColor)
            .frame(width: 50, height: 50)
            .overlay(
                Image(setting.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
            )
    }
    
    @ViewBuilder
    var title: some View {
        if setting.title == "Delete Account" {
            Button(action: deleteUser, label: {
                textOfTitle
                    
            })
        } else {
            textOfTitle
        }
    }
    
    var textOfTitle: some View {
        Text(setting.title)
            .font(AppTNowFont.regular.getFont(size: .h3))
            .multilineTextAlignment(.center)
            .foregroundColor(textColor)
    }
    
    @ViewBuilder
    var toggleBtn: some View {
        if setting.isToggel {
            Toggle("", isOn: $isToggelBtnPressed)
                .labelsHidden()
                .tint(.green)
        }else {
            Image(systemName: "chevron.right")
        }
    }
    
    var dividerView: some View {
        Divider()
            .frame(height: 1)
            .foregroundColor(backgroundColor)
    }
}

