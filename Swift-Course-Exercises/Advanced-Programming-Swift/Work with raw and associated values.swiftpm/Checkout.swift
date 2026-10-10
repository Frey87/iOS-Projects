//
//  Checkout.swift
//  Work with raw and associated values
//
//  Created by Valentyn Verovkin on 25.07.2026.
//

struct CheckoutItem {
    let name: String
    let price: Int
}


func calculateTotal(items: [CheckoutItem], localTaxPercent: Int) -> Int {
    let itemsTotal = items.reduce(0) { $0 + $1.price }
    let taxAmount = itemsTotal * localTaxPercent / 100
    return itemsTotal + taxAmount
}
