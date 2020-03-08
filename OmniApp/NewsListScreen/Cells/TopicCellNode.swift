//
//  TopicCellNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TopicCellNode: ASCellNode {
    let title = ASTextNode()
    
    init(topic: Topic) {
        super.init()
        title.attributedText = NSAttributedString(string: topic.title)
        selectionStyle = .none
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 5, left: 15, bottom: 5, right: 15), child: title)
    }
}
