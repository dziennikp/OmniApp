//
//  SelectedNewsReducerTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import XCTest
@testable import OmniApp
import ReSwift

class SelectedNewsReducerTests: XCTestCase {
    func testShouldHandleSelectedArticleAction() {
        let article = Article.stub()
        let action = SelectedNewsAction.article(article)
        let state = selectedNewsReducer(action: action, state: nil)
        XCTAssert(state.newsSelected)
        XCTAssertNil(state.selectedTopic)
        XCTAssertNotNil(state.selectedArticle)
    }
    
    func testShouldHandleSelectedTopicAction() {
        let topic = Topic.stub()
        let action = SelectedNewsAction.topic(topic)
        let state = selectedNewsReducer(action: action, state: nil)
        XCTAssert(state.newsSelected)
        XCTAssertNil(state.selectedArticle)
        XCTAssertNotNil(state.selectedTopic)
    }
    
    func testShouldHandleClearAction() {
        let topic = Topic.stub()
        var action = SelectedNewsAction.topic(topic)
        var state = selectedNewsReducer(action: action, state: nil)
        action = SelectedNewsAction.clear
        state = selectedNewsReducer(action: action, state: nil)
        XCTAssertFalse(state.newsSelected)
        XCTAssertNil(state.selectedTopic)
        XCTAssertNil(state.selectedArticle)
    }
    
    func testShouldReturnNewStateForOtherActions() {
        let action = FakeAction()
        let state = selectedNewsReducer(action: action, state: nil)
        XCTAssertFalse(state.newsSelected)
        XCTAssertNil(state.selectedTopic)
        XCTAssertNil(state.selectedArticle)
    }
    
    func testShouldReturnPresentStateForOtherActions() {
        let state = SelectedNewsState(selectedArticle: Article.stub().setting(\.title, to: "AA"), selectedTopic: nil)
        let action = FakeAction()
        let presentState = selectedNewsReducer(action: action, state: state)
        XCTAssert(presentState == state)

    }
}


fileprivate struct FakeAction: Action {}
