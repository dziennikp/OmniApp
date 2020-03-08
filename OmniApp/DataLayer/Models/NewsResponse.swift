//
//  NewsResponse.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 05/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation

struct NewsResponse: Decodable, Equatable {
    var articles: [Article]
    var topics: [Topic]
    
    var hasData: Bool {
        return articles.count > 0 || topics.count > 0
    }

    static func emptyNewsResponse() -> NewsResponse {
        return NewsResponse(articles: [], topics: [])
    }
}
