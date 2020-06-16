//
//  APISession.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation
import Alamofire
import Combine

public struct APISessionManager {
    
    static func sendRequest<T: APIRequest>(apiRequest: T) -> Future<T.ResponseType, APIError> {
        
        return Future<T.ResponseType, APIError> { (promise) in
            
            do {
                let requestUrl = try apiRequest.apiPath.asURL()
                AF.request(requestUrl, method: apiRequest.method, parameters: apiRequest.arguments, encoding: apiRequest.encoding, headers: apiRequest.headers).responseJSON { (response) in
                    print(response)
                    if let httpResponse = response.response {

                        let statusCode = httpResponse.statusCode

                        switch statusCode {
                        case 200...299:
                            
                            // guarantee correct data
                            guard let data = response.data else  {
                                promise(.failure(.invalidData))
                                return
                            }

                            // guarantee jsonObject is not nil
                            guard let jsonObject = try? JSONDecoder().decode(T.ResponseType.self, from: data) else {
                                promise(.failure(.jsonSerializationFailed))
                                return
                            }

                            // successful case
                            promise(.success(jsonObject))

                        case 401...499:
                            promise(.failure(.authenticationError))
                        case 500...599:
                            promise(.failure(.badRequest))
                        case 600:
                            promise(.failure(.outdated))
                        default:
                            promise(.failure(.failed))
                        }
                        return
                    }
                }
                
            } catch {
                return promise(.failure(APIError.failed))
            }
        }
        
    }

        
}
