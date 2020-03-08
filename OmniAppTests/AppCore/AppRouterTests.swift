//
//  AppRouterTests.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import XCTest
@testable import OmniApp
import AsyncDisplayKit
import ReSwift

class AppRouterTests: XCTestCase {
    var appRouter: AppRouter?
    var window = UIWindow()
    var appStore: MockAppStore?
    
    fileprivate var splitViewController: FakeSplitViewController? {
        return window.rootViewController as? FakeSplitViewController
    }
    override func setUp() {
        window = UIWindow()
        appStore = MockAppStore(reducer: appReducer, state: nil)
        appRouter = AppRouter(window: window, splitViewController: FakeSplitViewController(), store: appStore!)
    }
    
    func testShouldHaveInstantiatedListViewController() {
        guard let splitViewController = window.rootViewController as? SplitViewController else {
            XCTFail("Split view controller should root view controller")
            return
        }
        XCTAssert(splitViewController.children.count == 1)
        XCTAssert(splitViewController.children.first is UINavigationController)
        XCTAssert((splitViewController.children.first as? UINavigationController)?.children.first is ListScreenViewController)

    }
    
    func testShouldShowArticleDetailWhenArticleSelected() {
        let article = Article.stub().setting(\.title, to: "Test")
        let routingState = SelectedNewsState(selectedArticle: article, selectedTopic: nil)
        appRouter?.newState(state: routingState)
        XCTAssert(splitViewController?.showDetailsCalled == true)
        XCTAssert(splitViewController?.node is ArticleDetailNode == true)
    }
    
    func testShouldShowTopicDetailWhenTopicSelected() {
        let topic = Topic.stub().setting(\.title, to: "Test")
        let routingState = SelectedNewsState(selectedArticle: nil, selectedTopic: topic)
        appRouter?.newState(state: routingState)
        XCTAssert(splitViewController?.showDetailsCalled == true)
        XCTAssert(splitViewController?.node is TopicDetailNode == true)
    }
    
    func testShouldNotShowDetailsWhenNothingSelected() {
        let routingState = SelectedNewsState(selectedArticle: nil, selectedTopic: nil)
        appRouter?.newState(state: routingState)
        XCTAssert(splitViewController?.showDetailsCalled == false)
        XCTAssert(splitViewController?.node == nil)
    }
    
    func testShouldSubscribeToStoreChanges() {
        appStore?.dispatch(SelectedNewsAction.article(Article.stub().setting(\.title, to: "Test")))
        XCTAssert(splitViewController?.showDetailsCalled == true)
    }
}


fileprivate class FakeSplitViewController: SplitViewController {
    var showDetailsCalled = false
    var node: ASDisplayNode?
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        super.showDetailViewController(vc, sender: sender)
        showDetailsCalled = true
        node = (vc as? DetailsViewController)?.node
    }
}
