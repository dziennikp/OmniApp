//
//  RoutingReducer.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

func selectedNewsReducer(action: Action, state: SelectedNewsState?) -> SelectedNewsState {
    guard let action = action as? SelectedNewsAction else { return state ??  SelectedNewsState()}
    switch action {
    case .article(let article):
        return SelectedNewsState(selectedArticle: article, selectedTopic: nil)
    case .topic(let topic):
        return SelectedNewsState(selectedArticle: nil, selectedTopic: topic)
    case .clear:
        return SelectedNewsState()
    }
}
