//
//  ChangeDisplayTypeNode.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 07/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ChangeDisplayTypeNode: ASDisplayNode {
    
    override init() {
        super.init()
        setViewBlock {
            UISegmentedControl(items: ["Articles".uppercased(), "Topics".uppercased()])
        }
        style.width = ASDimension(unit: .fraction, value: 1)
        style.height = ASDimension(unit: .points, value: 50)
        style.flexShrink = 1
        
    }
}
