//
//  UIAdapter.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/15.
//  Copyright © 2020 ericji. All rights reserved.
//

import SwiftUI

class UIAdapter: ObservableObject {

    @Published var shouldPushRateView: Binding = .constant(false)
    
    @Published var selectedRate: String = "--"
    
    func clear() {
        shouldPushRateView = .constant(false)
        selectedRate = "--"
    }
    
}
