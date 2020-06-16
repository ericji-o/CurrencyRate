//
//  CurrencyViewModel.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/12.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation
import Combine

class CurrencyViewModel: ObservableObject {
    
    private var disposeBag = CancelBag()
    @Published var currencies: [Currency] = []
    @Published var selectedCurrencyCode: String = "--"

    deinit {
        self.disposeBag.cancelAll()
    }
    
    func fetchCurrencies() {
        
        APISessionManager.sendRequest(apiRequest: CurrencyRequest()).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                break
            case .failure(_):
                print("Error!")
            }
        }) { (currencyResponse) in
            let model = currencyResponse.asModel()
            self.currencies = model

        }.store(in: &disposeBag)
    }
    
    func clear() {
        self.selectedCurrencyCode = "--"
        // recall api
        self.fetchCurrencies()
    }
    
}
