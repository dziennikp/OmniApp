//
//  RoutingState.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

struct SelectedNewsState: StateType, Equatable {
    let selectedArticle: Article?
    let selectedTopic: Topic?
    
    var newsSelected: Bool {
        return selectedArticle != nil || selectedTopic != nil
    }
    
    init(selectedArticle: Article? = nil, selectedTopic: Topic? = nil) {
        self.selectedArticle = selectedArticle
        self.selectedTopic = selectedTopic
    }
}
