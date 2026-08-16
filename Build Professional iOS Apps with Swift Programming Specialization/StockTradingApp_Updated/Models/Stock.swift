//
//  Stock.swift
//  StockTradingApp_Updated
//
//  Created by Valentyn Verovkin on 24.03.2026.
//

import Foundation


struct Stock: Codable, Sendable {
    let name: String
    let stockExchange: String
    let price: String
    let percentage: String
    let lowerLimit: String
    let lowerLimitRange: String
    let upperLimit: String
    let upperLimitRange: String
}

extension Stock {
    /// Bundled demonstration values used when the temporary remote JSON source
    /// is unavailable. These values are illustrative and are not live prices.
    static let demoData: [Stock] = [
        Stock(
            name: "AAPL",
            stockExchange: "NASDAQ",
            price: "$198.45",
            percentage: "+1.25%",
            lowerLimit: "185",
            lowerLimitRange: "6",
            upperLimit: "205",
            upperLimitRange: "12"
        ),
        Stock(
            name: "MSFT",
            stockExchange: "NASDAQ",
            price: "$421.30",
            percentage: "+0.82%",
            lowerLimit: "405",
            lowerLimitRange: "8",
            upperLimit: "435",
            upperLimitRange: "14"
        ),
        Stock(
            name: "NVDA",
            stockExchange: "NASDAQ",
            price: "$136.20",
            percentage: "-0.64%",
            lowerLimit: "125",
            lowerLimitRange: "5",
            upperLimit: "145",
            upperLimitRange: "10"
        ),
        Stock(
            name: "AMZN",
            stockExchange: "NASDAQ",
            price: "$214.75",
            percentage: "+1.08%",
            lowerLimit: "200",
            lowerLimitRange: "7",
            upperLimit: "225",
            upperLimitRange: "11"
        ),
        Stock(
            name: "GOOGL",
            stockExchange: "NASDAQ",
            price: "$192.10",
            percentage: "-0.31%",
            lowerLimit: "180",
            lowerLimitRange: "6",
            upperLimit: "205",
            upperLimitRange: "10"
        )
    ]
}
