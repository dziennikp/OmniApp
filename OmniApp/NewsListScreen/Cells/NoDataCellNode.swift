//
//  NoDataCellNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 06/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NoDataCellNode: ASCellNode {
    let title: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "No data available")
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 15, left: 15, bottom: 5, right: 15), child: title)
    }
}
