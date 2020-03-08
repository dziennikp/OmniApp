//
//  NewsResponseTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import XCTest
@testable import OmniApp

class NewsResponseTests: XCTestCase {
    func testShouldCheckIfNewsResponseHasData() {
        var news = NewsResponse.stub().setting(\.articles, to: [Article.stub()])
        XCTAssert(news.hasData)
        news = NewsResponse.emptyNewsResponse()
        XCTAssertFalse(news.hasData)
        news = NewsResponse.stub().setting(\.topics, to: [Topic.stub()])
        XCTAssert(news.hasData)
    }
}
