//
//  RateRequest.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation
import Alamofire

struct RateRequest: APIRequest {    
    
    typealias ResponseType = RateResponse
    var apiPath: String = Constants.baseUrlString + .live
    var arguments: Parameters? = nil
    
    init(currencyCode: String) {
        self.arguments = [
            .accessKey: Constants.apiAccessKey,
            .source: currencyCode
        ]
    }
    
}

fileprivate extension String {
    static let live = "live"
    static let accessKey = "access_key"
    static let source = "source"
}
