//
//  APIError.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation

public enum APIError: String, Error {
    case parametersNil = "❌　Parameters were nil."
    case encodingFailed = "❌　Parameter encoding failed."
    case invalidURL = "❌　URL is invalid."
    case authenticationError = "❌　Authentication Error"
    case badRequest = "❌　Bad Request"
    case outdated = "❌　The url you requested is outdated."
    case invalidData = "❌　The input data nil or zero length."
    case jsonSerializationFailed = "❌　The json serialization failed."
    case stringSerializationFailed = "❌　The string serialization failed."
    case failed = "❌　Network request failed."
}
