//
//  SettingSection.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 06/08/2023.
//

import SwiftUI

struct SettingSection: Identifiable {
    let id = UUID()
    let section: String
    let settings: [SettingSubModel]
    
}
struct SettingSubModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let isToggel: Bool
    let destination: AnyView?
    
}
