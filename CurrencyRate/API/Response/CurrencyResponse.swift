//
//  CurrencyResponse.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation

// API Model
struct CurrencyResponse: Codable {
    let currencies: [String: String]
}

extension CurrencyResponse {
    
    func asModel() -> [Currency] {
        let keys = self.currencies.keys.sorted()
        var model = [Currency]()
        for (index, key) in keys.enumerated() {
            let currencyInfo = Currency(id: index, code: key, name: currencies[key] ?? "")
            model.append(currencyInfo)
        }
        return model
    }
}

// UI Model
struct Currency: Identifiable {
    let id: Int
    let code, name: String
}


