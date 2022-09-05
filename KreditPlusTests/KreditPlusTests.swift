//
//  KreditPlusTests.swift
//  KreditPlusTests
//
//  Created by Novi Gunawan on 04/09/22.
//

import XCTest
@testable import KreditPlus

struct ProductViewModel {
    let product: Products!
    var hasRating: Bool {
        return !product.title.isEmpty
    }
}
class KreditPlusTests: XCTestCase {
    var monitor: Products!

    override func setUpWithError() throws {
        super.setUp()
        
        monitor = Products(id: 1, title: "Samsung Monitor", price: 299, description: "A brand new monitor with outstanding performance", category: "electronics", image: "testString", rating: Rating(rate: 4.0, count: 200))
    }

    override func tearDownWithError() throws {

        monitor = nil
    }
    // MARK: -Test case to validate logic in ViewModel
    func testHasRating() {
        let viewModel = ProductViewModel(product: monitor)
        XCTAssert(viewModel.hasRating)
    }
}
