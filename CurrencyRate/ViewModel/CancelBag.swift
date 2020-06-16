//
//  CancelBag.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/12.
//  Copyright © 2020 ericji. All rights reserved.
//

import Combine

typealias CancelBag = Set<AnyCancellable>

extension CancelBag {
    
  mutating func cancelAll() {
    forEach { $0.cancel() }
    removeAll()
  }
    
}
