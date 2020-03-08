//
//  SplitViewController.swift
//  OmniApp
//
//  Created by Paweł Dziennik on 04/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        minimumPrimaryColumnWidth = 375
        preferredDisplayMode = .allVisible
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem =
            splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
}
