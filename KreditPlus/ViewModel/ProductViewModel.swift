//
//  ProductViewModel.swift
//  KreditPlus
//
//  Created by Novi Gunawan on 05/09/22.
//

import Foundation
import UIKit

struct ProductViewModel {
    let id: Int
    let title: String
    let description: String
    let image: String
    let price: Double
    let rating: Double
    
    // MARK: Dependency Injection
    
    init(product: Products) {
        self.id = product.id
        self.title = product.title
        self.description = product.description
        self.image = product.image
        self.price = product.price
        self.rating = product.rating.rate
    }

}
