//
//  NewsService.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import PromiseKit

class NewsService {
    
    func fetchNews(query: String) -> Promise<NewsResponse> {
        guard let url = URL(string: "https://omni-content.omni.news/search?query=" + query) else {  return Promise<NewsResponse>(error: APIError.badRequest) }
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.map {
            return try JSONDecoder().decode(NewsResponse.self, from: $0.data)
        }
    }
}

enum APIError: Error {
    case badRequest
}
