//
//  ArticleCellNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 05/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ArticleCellNode: ASCellNode {
    let title = ASTextNode()
    let image: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        node.cropRect = CGRect(x: 0, y: 0, width: 0.0, height: 0.0)
        return node
    }()
    
    init(article: Article) {
        super.init()
        automaticallyManagesSubnodes = true
        title.attributedText = NSAttributedString(string: article.title)
        image.url = article.imageURL
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        image.style.preferredSize = CGSize(width: constrainedSize.max.width , height: constrainedSize.max.width)
        let titleWithPadding = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 10, bottom: 5, right: 10), child: title)
        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .start,
                                            alignItems: .start,
                                            children: [titleWithPadding, image])
        return mainStack
    }
}
