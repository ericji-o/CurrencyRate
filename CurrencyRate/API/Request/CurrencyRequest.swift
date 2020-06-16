//
//  CurrencyRequest.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation
import Alamofire

struct CurrencyRequest: APIRequest {
    
    typealias ResponseType = CurrencyResponse
    
    var apiPath: String = Constants.baseUrlString + .list
    var arguments: Parameters? = [.accessKey: Constants.apiAccessKey]
    
}

fileprivate extension String {
    static let list = "list"
    static let accessKey = "access_key"
}
