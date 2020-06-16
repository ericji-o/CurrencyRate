//
//  LocalDataManager.swift
//  CurrencyRate
//
//  Created by Eric JI on 2020/06/16.
//  Copyright © 2020 ericji. All rights reserved.
//

import Foundation

struct LocalDataManager {
    
    static func setup() throws {
        try FileManager.default.createDirectory(atPath: .rateFolder, withIntermediateDirectories: true, attributes: nil)
    }
    
    static func writeToLocalFile(_ data: RateResponse, fileName: String) throws {
        
        var data = data
        data.lastTimeForAPI = Date().timeIntervalSince1970 as Double
        
        let filePath = .rateFolder + fileName + .extensionJson
        let fileUrl = URL(fileURLWithPath: filePath)
        
        let encoder: JSONEncoder = JSONEncoder()
        let encodingData = try encoder.encode(data)
        try encodingData.write(to: fileUrl)
    }
    
    static func readFromLocalFile(_ fileName: String) throws -> RateResponse? {
        
        let filePath = .rateFolder + fileName + .extensionJson
        let fileUrl = URL(fileURLWithPath: filePath)
        
        let data = try Data(contentsOf: fileUrl)
        
        let decoder: JSONDecoder = JSONDecoder()

        let object = try decoder.decode(RateResponse.self, from: data)
        
        return object
        
    }
    
}

fileprivate extension String {
    
    static let rateFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/rates/"
    static let extensionJson = ".json"
}
