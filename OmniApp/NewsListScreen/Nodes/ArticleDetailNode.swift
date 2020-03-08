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
    let isPhone = UIDevice.current.userInterfaceIdiom == .phone

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
            NSAttributedString(string: $0.text.value, attributes: LabelStyle.textAttributes)
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
                                          spacing: 10.0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [title, text])
        var offset: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        if isPhone { offset += 50 }
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: offset, left: 15, bottom: 0, right: 15), child: mainStack)
    }
}
 
