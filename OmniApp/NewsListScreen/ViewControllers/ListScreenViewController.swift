//
//  ListScreenViewController.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit
import PromiseKit
import ReSwift

class ListScreenViewController: ASViewController<ASDisplayNode> {
    private var searchBar: UISearchBar {
        searchBarNode.view as! UISearchBar
    }
    private var changeDisplayTypeView: UISegmentedControl {
        changeDisplayTypeNode.view as! UISegmentedControl
    }
    
    private var searchBarNode = SearchBarNode()
    private var changeDisplayTypeNode = ChangeDisplayTypeNode()

    private lazy var tableNode = NewsListNode()
    private let isPad = UIDevice.current.userInterfaceIdiom == .pad

    private var news: NewsResponse = NewsResponse.emptyNewsResponse() {
        didSet {
            tableNode.allowsSelection = news.hasData
            guard news != oldValue else { return }
            tableNode.reloadData()
        }
    }
    private var currentDisplayType: NewsDisplayType = .articles {
        didSet {
            guard currentDisplayType != oldValue else { return }
            tableNode.reloadData()
        }
    }
    
    private var showArticles: Bool {
        return currentDisplayType == .articles
    }
    
    private var layout: ASLayoutSpec {
        let topOffset: CGFloat = view.safeAreaInsets.top
        let stack = ASStackLayoutSpec(direction: .vertical,
                                      spacing: 0,
                                      justifyContent: .center,
                                      alignItems: .start,
                                      children: [self.changeDisplayTypeNode, self.searchBarNode,  self.tableNode])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: topOffset, left: 0, bottom: 0, right: 0), child: stack)
    }
    
    private let store: Store<AppState>
    
    init(store: Store<AppState>) {
        self.store = store
        super.init(node: ASDisplayNode())
        store.subscribe(self) {
            $0.select {
                $0.searchState
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in
            self.layout
        }
        tableNode.dataSource = self
        tableNode.delegate = self
        node.backgroundColor = .white
        searchBar.delegate = self
        changeDisplayTypeView.addTarget(self, action: #selector(changeDisplayType), for: .valueChanged)
        changeDisplayTypeView.selectedSegmentIndex = showArticles ? 0 : 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(SelectedNewsAction.clear)
        if isPad {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        node.setNeedsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeDisplayType() {
        let type: NewsDisplayType = changeDisplayTypeView.selectedSegmentIndex == 0 ? .articles : .topics
        store.dispatch(NewsListAction.switchDisplayType(type: type))
    }
}

extension ListScreenViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        store.dispatch(NewsListAction.search(query: searchBar.text ?? ""))
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
        perform(#selector(performSearch), with: nil, afterDelay: 0.5)
    }
    
    @objc func performSearch() {
        store.dispatch(NewsListAction.search(query: searchBar.text ?? ""))
    }
}

extension ListScreenViewController: ASTableDataSource,ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = showArticles ? news.articles.count : news.topics.count
        return max(rowsCount, 1)
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let nodeBlock: ASCellNodeBlock = {
            switch self.currentDisplayType {
            case .articles where self.news.articles.count > 0 &&
                 self.news.articles.indices.contains(indexPath.row) == true :
                return ArticleCellNode(article: self.news.articles[indexPath.row])
            case .topics  where self.news.topics.count > 0 &&
                self.news.topics.indices.contains(indexPath.row) == true:
                return TopicCellNode(topic: self.news.topics[indexPath.row])
            default:
                return NoDataCellNode()
            }
        }
        return nodeBlock
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        searchBar.endEditing(true)
        switch currentDisplayType {
        case .articles:
            guard news.articles.indices.contains(indexPath.row) else { return }
            store.dispatch(SelectedNewsAction.article(news.articles[indexPath.row]))
        case .topics:
            guard news.topics.indices.contains(indexPath.row) else { return }
            store.dispatch(SelectedNewsAction.topic(news.topics[indexPath.row]))
        }
    }
}

extension ListScreenViewController: StoreSubscriber {
    func newState(state: NewsListState) {
        if currentDisplayType != state.newsDisplayType  {
            currentDisplayType = state.newsDisplayType
            return
        }
        guard state.results != nil else {
            news = NewsResponse.emptyNewsResponse()
            return
        }
        tableNode.refreshControl.beginRefreshing()

        state.results?.done {
            self.news = $0
        }.catch { error in
            self.news = NewsResponse.emptyNewsResponse()
            debugPrint(error)
        }.finally {
            self.tableNode.refreshControl.endRefreshing()
        }
    }
}
