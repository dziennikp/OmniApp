//
//  NewsListState.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift
import PromiseKit

struct NewsListState: StateType {
    let results: Promise<NewsResponse>?
    let newsDisplayType: NewsDisplayType
    
    init(results: Promise<NewsResponse>? = nil, newsDisplayType: NewsDisplayType = .articles) {
        self.results = results
        self.newsDisplayType = newsDisplayType
    }
}
