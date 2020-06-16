//
//  RateResponse.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation

// API Model
struct RateResponse: Codable {
    let quotes: [String: Float]
    var lastTimeForAPI: Double?
}

extension RateResponse {
    
    func asModel() -> [Rate] {
        let keys = self.quotes.keys.sorted()
        var model = [Rate]()
        for (index, key) in keys.enumerated() {
            let rateInfo = Rate(id: index, name: key, value: quotes[key] ?? 0.0)
            model.append(rateInfo)
        }
        return model
    }
}

// UI Model
struct Rate: Identifiable {
    let id: Int
    let name: String
    let value: Float
}
