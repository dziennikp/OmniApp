//
//  TopicDetailNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 07/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TopicDetailNode: ASDisplayNode {
    let title = ASTextNode()
    let type = ASTextNode()
    
    init(topic: Topic) {
        super.init()
        automaticallyManagesSubnodes = true
        title.attributedText = NSAttributedString(string: topic.title, attributes:
            LabelStyle.titleAttributes)
        type.attributedText = NSAttributedString(string: topic.type)
        style.width = ASDimension(unit: .fraction, value: 1)
        style.height = ASDimension(unit: .fraction, value: 1)
        style.flexShrink = 1
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 6.0,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [title, type])

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0), child: mainStack)
    }
}
