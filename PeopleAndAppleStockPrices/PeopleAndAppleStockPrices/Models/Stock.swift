//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Levi Davis on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stock: Codable {
    let date: String
    let close: Double
    let open: Double
    let label: String
    
    
    static func getPrices(from data: Data) -> [Stock] {
        do {
            let stockResults = try JSONDecoder().decode([Stock].self, from: data)
            return stockResults
        } catch let decodeError {
            fatalError("Error: \(decodeError)")
        }
    }
}
