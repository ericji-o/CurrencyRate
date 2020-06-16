//
//  CurrencyCell.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/12.
//  Copyright © 2020 ericji. All rights reserved.
//

import SwiftUI

struct CurrencyCell: View {
    
    let currency: Currency
    var body: some View {
        
        HStack(alignment: .firstTextBaseline) {
            Text(currency.name)
                .font(.system(size: 22))
                .padding(.leading, 20)
            
            Text(currency.code)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.trailing, 20)
        }.background(Color("Green"))
            .cornerRadius(15)
        
    }
}

#if DEBUG

struct CurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCell(currency: Currency(id: 1, code: "jiyun", name: "Eric"))
    }
}

#endif
