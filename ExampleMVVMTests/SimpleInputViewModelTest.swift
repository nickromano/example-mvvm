//
//  SimpleInputViewModelTest.swift
//  ExampleMVVMTests
//
//  Created by Nicholas Romano on 1/26/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import XCTest
@testable import ExampleMVVM

class SimpleInputViewModelTest: XCTestCase {
    func testTextFieldIsValidated() {
        let viewModel = SimpleInputViewModel()

        XCTAssertEqual(viewModel.myTextFieldText, "")
        XCTAssertEqual(viewModel.myButtonIsEnabled, false)

        viewModel.inputMyTextFieldText = "tESt"
        XCTAssertEqual(viewModel.myTextFieldText, "test")
        XCTAssertEqual(viewModel.myButtonIsEnabled, false)

        viewModel.inputMyTextFieldText = "tESting"
        XCTAssertEqual(viewModel.myTextFieldText, "testing")
        XCTAssertEqual(viewModel.myButtonIsEnabled, true)
    }
}
