//
//  NewsListNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 07/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsListNode: ASTableNode {
    let refreshControl = UIRefreshControl()
    
    init() {
        super.init(style: .plain)
        view.separatorStyle = .none
        backgroundColor = .white
        style.width = ASDimension(unit: .fraction, value: 1)
        style.height = ASDimension(unit: .fraction, value: 1)
        style.flexShrink = 2
        view.refreshControl = refreshControl
        view.bounces = false
    }
}
