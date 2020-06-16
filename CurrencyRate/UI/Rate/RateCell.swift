//
//  RateCell.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/15.
//  Copyright © 2020 ericji. All rights reserved.
//

import SwiftUI

struct RateCell: View {
    
    let rate: Rate
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(rate.name)
                .font(.system(size: 22))
                .padding(.leading, 20)
            Spacer()
            Text("\(rate.value)")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.trailing, 20)
        }
    }
}

struct RateCell_Previews: PreviewProvider {
    static var previews: some View {
        RateCell(rate: Rate(id: 0, name: "Test", value: 0.32))
    }
}
