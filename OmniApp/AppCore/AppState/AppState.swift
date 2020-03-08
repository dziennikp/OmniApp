//
//  AppState.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    let selectedNewsState: SelectedNewsState
    let searchState: NewsListState
}
