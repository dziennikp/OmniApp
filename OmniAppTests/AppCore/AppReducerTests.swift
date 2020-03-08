//
//  AppRedcuerTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import XCTest
@testable import OmniApp
import ReSwift
class AppStateTests: XCTestCase {
    func testShouldReturnAppStateWhenStateIsNil() {
        XCTAssertFalse(appReducer(action: FakeAction(), state: nil).routingState.newsSelected)
    }
}


fileprivate struct FakeAction: Action {
    
}
