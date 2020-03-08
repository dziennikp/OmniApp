//
//  AppReducer.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(selectedNewsState: selectedNewsReducer(action: action, state: state?.selectedNewsState),
                    searchState: newsListReducer(action, state?.searchState)
    )
}
