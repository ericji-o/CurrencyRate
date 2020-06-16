//
//  RateView.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/15.
//  Copyright © 2020 ericji. All rights reserved.
//

import SwiftUI
import Combine

struct RateView: View {
    
    @EnvironmentObject var adapter: UIAdapter

    let code: String
    
    @ObservedObject var rateViewModel: RateViewModel

    init(code: String) {
        
        self.code = code
        rateViewModel = RateViewModel()
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            List {
                ForEach(self.rateViewModel.rates, id: \.id) { (data) in
                    RateCell(rate: data)
                    .onTapGesture {
                        self.adapter.selectedRate = "\(data.value)"
                        self.adapter.shouldPushRateView = .constant(false)
                    }
                }
            }
        }.onAppear {
            self.rateViewModel.fetchRates(with: self.code)
        }.onDisappear {
            self.adapter.shouldPushRateView = .constant(false)
        }
        .navigationBarTitle("Rate")
        
    }
}
        

fileprivate extension String {
    static let selectRate = "Select Rate"
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(code: "USD")
    }
}
