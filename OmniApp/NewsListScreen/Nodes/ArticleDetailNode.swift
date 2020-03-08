//
//  ArticleDetailNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 07/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ArticleDetailNode: ASDisplayNode {
    let title = ASTextNode()
    let text = ASTextNode()
    
    init(article: Article) {
        super.init()
        automaticallyManagesSubnodes = true
        title.attributedText = NSAttributedString(string: article.title, attributes: LabelStyle.titleAttributes)
        text.attributedText = mainText(from: article.text)
        style.width = ASDimension(unit: .fraction, value: 1)
        style.height = ASDimension(unit: .fraction, value: 1)
        style.flexShrink = 1
    }
    
    private func mainText(from articleText: ArticleText) -> NSAttributedString {
        var isFirst = true
        return articleText.paragraphs.map {
            NSAttributedString(string: $0.text.value)
        }.reduce(NSMutableAttributedString()) { (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(NSAttributedString(string: "\r\n\r\n"))
            }
            r.append(e)
            return r
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 6.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [title, text])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0), child: mainStack)
    }
}
