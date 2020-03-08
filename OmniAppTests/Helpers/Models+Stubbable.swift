//
//  Article+Stubbable.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
@testable import OmniApp

extension Article: Stubbable {
    static func stub() -> Article {
        return Article()
    }
}

extension ArticleText: Stubbable {
    static func stub() -> ArticleText {
        return ArticleText()
    }
}

extension Topic: Stubbable {
    static func stub() -> Topic {
        return Topic(title: "", type: "")
    }
}

extension NewsResponse: Stubbable {
    static func stub() -> NewsResponse {
        return NewsResponse(articles: [], topics: [])
    }
}
