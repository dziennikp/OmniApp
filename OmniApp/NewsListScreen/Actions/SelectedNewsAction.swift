//
//  SelectedNewsAction.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 07/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift

enum SelectedNewsAction: Action {
    case article(Article), topic(Topic), clear
}
