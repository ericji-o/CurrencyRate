//
//  RateViewModel.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/12.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation
import Combine

class RateViewModel: ObservableObject {
    
    private var disposeBag = CancelBag()
    @Published var rates: [Rate] = []
    @Published var selectedRate: String = "--"

    deinit {
        self.disposeBag.cancelAll()
    }

    func fetchRates(with code: String) {
        // check data should be loaded from api or loacl data
        if let responseData = try? LocalDataManager.readFromLocalFile(code), let lastTime = responseData.lastTimeForAPI {
            let currentTime = Date().timeIntervalSince1970
            let diff = currentTime - lastTime
            if  Int(diff/60) > 30 {
                // beyond 30mins
                // call api
                loadServerData(with: code)
            } else {
                self.rates = responseData.asModel()
            }
        } else {
            // first time call api
            loadServerData(with: code)
        }
    }
    
    
    func loadServerData(with code: String) {

        APISessionManager.sendRequest(apiRequest: RateRequest(currencyCode: code)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                break
            case .failure(_):
                print("Error!")
            }
        }) { (rateResponse) in
            try? LocalDataManager.writeToLocalFile(rateResponse, fileName: code)
            let model = rateResponse.asModel()
            self.rates = model

        }.store(in: &disposeBag)
    }
    
    func selectRate(with index: Int) {
        selectedRate = "\(rates[index].value)"
    }
    
}
