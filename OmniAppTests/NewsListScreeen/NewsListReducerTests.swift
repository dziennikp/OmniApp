//
//  NewsListReducerTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import XCTest
@testable import OmniApp
import ReSwift
import OHHTTPStubs

class NewsListReducerTests: XCTestCase {
    override func setUp() {
        super.setUp()
        stub(condition: isHost("omni-content.omni.news")) { _ in
          // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
          let stubPath = OHPathForFile("newsResponse.json", type(of: self))
          return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
    
    func testShouldReturnSearchQueryResults() {
        let action = NewsListAction.search(query: "test")
        let state = newsListReducer(action, nil)
        XCTAssertNotNil(state.results)
        XCTAssert(state.newsDisplayType == .articles)
    }
    
    func testShouldReturnChangedNewsDisplayType() {
        let action = NewsListAction.switchDisplayType(type: .topics)
        let state = newsListReducer(action, nil)
        XCTAssertNil(state.results)
        XCTAssert(state.newsDisplayType == .topics)
    }
    
    func testShouldReturnNewStateForOtherActions() {
        let action = FakeAction()
        let state = newsListReducer(action, nil)
        XCTAssert(state.newsDisplayType == .articles)
        XCTAssertNil(state.results)
    }
    
    func testShouldReturnPresentStateForOtherActions() {
        let previousState = NewsListState(results: nil, newsDisplayType: .topics)
        let action = FakeAction()
        let state = newsListReducer(action, previousState)
        XCTAssert(state.newsDisplayType == .topics)
        XCTAssertNil(state.results)
    }
}


fileprivate struct FakeAction: Action {}
