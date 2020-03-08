//
//  Stubbable.swift
//  OmniAppTests
//
//  Created by Paweł Dziennik on 08/03/2020.
//  Copyright © 2020 Crux Solutions. All rights reserved.
//

import Foundation

protocol Stubbable {
    static func stub() -> Self
}

extension Stubbable {
    func setting<T>(_ keyPath: WritableKeyPath<Self, T>,
                    to value: T) -> Self {
        var stub = self
        stub[keyPath: keyPath] = value
        return stub
    }
}
