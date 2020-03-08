//
//  DetailsViewController.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class DetailsViewController: ASViewController<ASDisplayNode> {
    
    override func viewDidLoad() {
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        node.setNeedsLayout()
    }
}
