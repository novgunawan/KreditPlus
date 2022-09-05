//
//  Products.swift
//  KreditPlus
//
//  Created by Novi Gunawan on 04/09/22.
//

import Foundation


enum Category: Codable {
    case menClothing
    case jewelery
    case electronics
    case womenClothing
    
}
struct Products: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
}
