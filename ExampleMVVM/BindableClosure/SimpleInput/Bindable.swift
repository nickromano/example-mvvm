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

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: Listener?) {
        if listener != nil {
            fatalError("Only supports one listener at a time.")
        }
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
