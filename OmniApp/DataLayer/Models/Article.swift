//
//  Article.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 05/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation

struct Article: Decodable, Equatable {
    var imageURL: URL? {
        URL(string: "https://gfx-ios.omni.se/images/" + imageName)
    }
    var title: String
    var imageName: String
    var text: ArticleText
    
    init() {
        title = ""
        imageName = ""
        text = ArticleText()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let titleSection = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .title)
        title = try titleSection.decode(String.self, forKey: .value)
        let mainResourceSection = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main_resource)
        let imageAssetSection = try mainResourceSection.nestedContainer(keyedBy: CodingKeys.self, forKey: .image_asset)
        imageName = try imageAssetSection.decode(String.self, forKey: .id)
        text = try container.decode(ArticleText.self, forKey: .main_text)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, value, main_resource, image_asset, id, main_text
    }
}
