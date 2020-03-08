//
//  SearchNewsAction.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift
import PromiseKit

struct SearchNewsAction: Action {
    let query: String
}

let newsReducer: Reducer<SearchState?> = { (action, state) -> SearchState? in
    var state = state ?? SearchState()
    guard let action = action as? SearchNewsAction else { return nil }
    return SearchState(results: NewsService().fetchNews(query: action.query))
}

struct SearchState: StateType {
    let query: String?
    let results: Promise<NewsResponse>?
}

class NewsService {
    
    func fetchNews(query: String) -> Promise<NewsResponse> {
        let url = URL(string: "https://omni-content.omni.news/search?query=" + query)!
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.map {
            return try JSONDecoder().decode(NewsResponse.self, from: $0.data)
        }
    }
}
