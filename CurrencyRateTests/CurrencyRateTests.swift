//
//  CurrencyRateTests.swift
//  CurrencyRateTests
//
//  Created by Eric JI on 2020/06/11.
//  Copyright © 2020 ericji. All rights reserved.
//

import XCTest
@testable import CurrencyRate

class CurrencyRateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try LocalDataManager.setup()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidNumber() {
        XCTAssertTrue("2.0".isValidNumber(), "❌Wrong")
        XCTAssertTrue("4.3".isValidNumber(), "❌Wrong")
        XCTAssertTrue("300".isValidNumber(), "❌Wrong")
        XCTAssertFalse("00100".isValidNumber(), "❌Wrong")
        XCTAssertFalse("aaabbbcc".isValidNumber(), "❌Wrong")
        XCTAssertFalse("あいうえお".isValidNumber(), "❌Wrong")
    }
    
    func testLocalData() throws {
        // mock data
        let data = RateResponse(quotes: ["USDAED": 3.67, "USDALL": 110.23])
        try LocalDataManager.writeToLocalFile(data, fileName: "USD")
        let result = try LocalDataManager.readFromLocalFile("USD")
        XCTAssertNotNil(result, "❌failed to read local data")
        XCTAssertEqual(data.quotes, result!.quotes, "❌incorrect data")
        XCTAssertEqual(data.quotes["USDAED"], result!.quotes["USDAED"], "❌incorrect data")
        XCTAssertNotEqual(data.quotes["USDAED"], result!.quotes["USDALL"], "❌incorrect data")
    }
    
    func testCurrencyListAPI() {
        
        let expectation = self.expectation(description: "async test network")
                
        let cancellable = APISessionManager.sendRequest(apiRequest: CurrencyRequest()).sink(receiveCompletion: { (completion) in
            if case .finished = completion {
              expectation.fulfill()
            }
        }) { (currencyResponse) in
            let model = currencyResponse.asModel()
            XCTAssertTrue(model.count > 0)
            XCTAssertNotNil(model)
        }
        self.waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertNotNil(cancellable, "❌incorrect api request")
    }
    
    func testRateListAPI() {
        
        let expectation = self.expectation(description: "async test network")
                
        let cancellable = APISessionManager.sendRequest(apiRequest: RateRequest(currencyCode: "USD")).sink(receiveCompletion: { (completion) in
            if case .finished = completion {
              expectation.fulfill()
            }
        }) { (rateResponse) in
            let model = rateResponse.asModel()
            XCTAssertTrue(model.count > 0)
            XCTAssertNotNil(model)
        }
        self.waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertNotNil(cancellable, "❌incorrect api request")
    }


}


fileprivate extension String {
    
    func isValidNumber() -> Bool {
        let expression = "^([1-9][0-9]*)((\\.)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: self, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, self.count))
        return numberOfMatches != 0

    }
}

