//
//  BusinessCategoryModel.swift
//  AppTNow
//
//  Created by Qazi Ammar Arshad on 24/10/2023.
//

import Foundation

struct BusinessCategory: Codable, Identifiable {
    let id: Int
    let name: String
    let created_at: String
    let updated_at: String
}

let mockBusinessCategories = [BusinessCategory(id: 1, name: "IT Company", created_at: "02/10/23 18:03", updated_at: "02/10/23 18:03"),
                              BusinessCategory(id: 2, name: "Consultency", created_at: "02/10/23 18:03", updated_at: "02/10/23 18:03")
]
