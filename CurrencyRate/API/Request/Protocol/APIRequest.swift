//
//  APIRequest.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest {
    
    associatedtype ResponseType: Codable
    
    var apiPath: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: HTTPHeaders? { get }

    var arguments: Parameters? { get }

    var encoding: ParameterEncoding { get}
    
}

extension APIRequest {
    
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
    var arguments: Parameters? { return nil }
    var encoding: ParameterEncoding { return URLEncoding.default }

}

