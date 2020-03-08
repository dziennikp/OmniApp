//
//  AppRouter.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import ReSwift
import AsyncDisplayKit

class AppRouter: StoreSubscriber {
    private let splitViewController: SplitViewController
    private let store: Store<AppState>
    
    init(window: UIWindow, splitViewController: SplitViewController = SplitViewController(), store: Store<AppState>) {
        self.store = store
        self.splitViewController = splitViewController
        let navigationController = UINavigationController(rootViewController: ListScreenViewController(store: store))
        splitViewController.viewControllers = [navigationController]
        window.rootViewController = splitViewController
        store.subscribe(self) {
            return $0.skip {
                $0.routingState == $1.routingState
            }.select {
                $0.routingState
            }
        }
    }
    
    func newState(state: SelectedNewsState) {
        guard state.newsSelected else { return }
        var node = DetailsViewController()
        if let article = state.selectedArticle {
            node = DetailsViewController(node: ArticleDetailNode(article: article))
        } else if let topic = state.selectedTopic {
            node = DetailsViewController(node: TopicDetailNode(topic: topic))
        }
        splitViewController.showDetailViewController(node, sender: self)
    }
}


