//
//  Bindable.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/27/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import Foundation

class Bindable<T> {
    typealias Listener = ((T) -> Void)

    var listeners: [Listener?] = []

    var value: T {
        didSet {
            listeners.forEach { listener in
                listener?(value)
            }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        listeners.append(listener)
    }

    func bindAndFire(_ listener: Listener?) {
        listeners.append(listener)
        listener?(value)
    }
}
