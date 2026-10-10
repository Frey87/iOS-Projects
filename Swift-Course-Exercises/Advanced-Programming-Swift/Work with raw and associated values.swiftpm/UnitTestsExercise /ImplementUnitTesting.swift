//
//  ImplementUnitTesting.swift
//  Work with raw and associated values
//
//  Created by Valentyn Verovkin on 25.07.2026.
//

import XCTest

@testable import ImplementUnitTesting

final class ImplementUnitTestingTests: XCTestCase {

  func test_calculateTotal_salesTaxTwentyPercent() {
    let items = [
      CheckoutItem(name: "Fish and Chips", price: 625),
      CheckoutItem(name: "Cheeseburger", price: 850),
      CheckoutItem(name: "Milkshake", price: 325),
      CheckoutItem(name: "Black Coffee", price: 175),
    ]
    let taxPercentage = 20

    let totalToPay = calculateTotal(items: items, localTaxPercent: taxPercentage)

    XCTAssertEqual(totalToPay, 2370)
  }
}
