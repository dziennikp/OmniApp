//
//  NewsListReducer.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

let newsListReducer: Reducer<NewsListState> =  { (action, state) -> NewsListState in
    var state = state ?? NewsListState()
    guard let action = action as? NewsListAction else { return state }
    switch action {
    case .search(let query):
        return NewsListState(results: NewsService().fetchNews(query: query),
                           newsDisplayType: state.newsDisplayType)
    case .switchDisplayType(let type):
        return NewsListState(results: state.results,
                           newsDisplayType: type)
    }
}
