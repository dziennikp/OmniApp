//
//  NewsServiceTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
@testable import OmniApp
import XCTest
import OHHTTPStubs

class NewsServiceTests: XCTestCase {
    var service = NewsService()

    override func setUp() {
        super.setUp()
        service = NewsService()

        stub(condition: isHost("omni-content.omni.news")) { _ in
          // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
          let stubPath = OHPathForFile("newsResponse.json", type(of: self))
          return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
    
    func testShouldHandleInvalidQuery() {
        let expectation = XCTestExpectation()
        service.fetchNews(query: "1234xvc Jv 09123 mn sa").done { _ in
            XCTFail()
        }.catch {
            XCTAssert($0 is APIError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testShouldDecodeQueryIntoNewsResponse() {
        let expectation = XCTestExpectation()
        service.fetchNews(query: "a").done { response in
            XCTAssert(response.hasData)
            expectation.fulfill()
        }.catch { _ in
            XCTFail()
        }
        wait(for: [expectation], timeout: 5)
    }
}
