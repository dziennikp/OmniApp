//
//  ArticleTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import XCTest
@testable import OmniApp

class ArticleTests: XCTestCase {
    func testShouldReturnURLForImage() {
        let article = Article.stub().setting(\.imageName, to: "testImage")
        XCTAssert(article.imageURL == URL(string: "https://gfx-ios.omni.se/images/testImage"))
    }
}
