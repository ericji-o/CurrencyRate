//
//  ContentView.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var adapter: UIAdapter
    @ObservedObject var currencyViewModel: CurrencyViewModel
    @State private var amount: String = "0"
    @State private var result: String = "0"
    
    init() {
        // Setting Style for List
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        currencyViewModel = CurrencyViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                selectedInfoView()
                outputTextField()
                HStack {
                    inputTextField()
                    calculateButton()
                }
                List {
                    ForEach(currencyViewModel.currencies, id: \.id) { data in
                        CurrencyCell(currency: data)
                            .onTapGesture {
                                self.currencyViewModel.selectedCurrencyCode = data.code
                                self.adapter.shouldPushRateView = .constant(true)
                        }
                    }
                }
                .navigationBarTitle(String.currency)
                .navigationBarItems(trailing: self.navigationRightButton())
            }
        }.onAppear {
            self.currencyViewModel.fetchCurrencies()
        }.onTapGesture {
            self.hideKeyboard()
        }.sheet(isPresented: adapter.shouldPushRateView) {
            RateView(code: "USD").environmentObject(self.adapter)
        }
        
    }
    
    // MARK: - UI Components

    private func navigationRightButton() -> some View {
        
        Button(action: {
            // redo
            self.result = "0"
            self.amount = "0"
            self.adapter.clear()
            self.currencyViewModel.clear()
            
        }) {
            Image(systemName: "arrow.clockwise")
            .renderingMode(.template)
            .foregroundColor(.black)

        }
        
    }
    
    private func selectedInfoView() -> some View {
           
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Selected Currency")
                    .font(.callout)
                    .bold()
                Text("\(currencyViewModel.selectedCurrencyCode)")
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Selected Rate")
                    .font(.callout)
                    .bold()
                Text("\(adapter.selectedRate)")
            }
        }
        .padding([.leading, .trailing])
           
    }
    
    private func inputTextField() -> some View {
        
        VStack(alignment: .leading) {
            Text("Amounts")
                .font(.callout)
                .bold()
            TextField("Input your amounts", text: $amount)
                .textFieldStyle(PlainTextFieldStyle())
                .keyboardType(.decimalPad)
                .onReceive(Just(self.amount)) { input in
                    self.amount = self.validateUser(input)
            }
            Divider().background(Color.gray)
        }
        .padding([.leading, .trailing])
        
    }
    
    private func calculateButton() -> some View {
        
        Button(action: {
            guard let correctRate = Double(self.adapter.selectedRate) else { return }
            guard let amount = Double(self.amount) else { return }
            self.result = String(amount * correctRate)
        }) {
            Image(systemName: "equal.square")
            .foregroundColor(.black)
        }.padding([.leading, .trailing])
        
    }
    
    private func outputTextField() -> some View {
        
        VStack(alignment: .leading) {
            Text("Result")
                .font(.callout)
                .bold()
            Text("\(self.result)")
        }
        .padding()
        
    }
    
    // MARK: - Handling Funcs
    private func validateUser(_ input: String) -> String {
        
        guard input.isValidNumber() else {
            let output = String(input.dropLast())
            return output
        }
        
        return input
        
    }
    
}

fileprivate extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

fileprivate extension String {
    static let currency = "Currency"
    
    func isValidNumber() -> Bool {
        let expression = "^([1-9][0-9]*)((\\.)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: self, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
        return numberOfMatches != 0

    }
}

#if DEBUG

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UIAdapter())
    }
}

#endif





