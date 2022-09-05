//
//  Products.swift
//  KreditPlus
//
//  Created by Novi Gunawan on 04/09/22.
//

import Foundation

struct Rating: Codable {
    let rate: Double
    let count: Int
}
struct Products: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}
