//
//  NSObject+ClassName.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/26/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
