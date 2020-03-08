//
//  NewsListAction.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

enum NewsListAction: Action {
    case search(query: String)
    case switchDisplayType(type: NewsDisplayType)
}
