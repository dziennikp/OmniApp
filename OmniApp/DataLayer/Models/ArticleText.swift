//
//  ArticleText.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation

struct ArticleText: Decodable, Equatable {
    struct ArticleParagraph: Decodable, Equatable {
        struct Text: Decodable, Equatable {
            let value: String
        }
        let text: Text
    }
    
    var type = ""
    var paragraphs: [ArticleParagraph] = []
    
    init() {
        type = ""
        paragraphs = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        paragraphs = try container.decode([ArticleParagraph].self, forKey: .paragraphs)
    }
    
    enum CodingKeys: String, CodingKey {
        case paragraphs, type, value, text
    }
}
