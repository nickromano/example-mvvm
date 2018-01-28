//
//  CSViewModelTest.swift
//  ExampleMVVMTests
//
//  Created by Nicholas Romano on 1/27/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import XCTest
@testable import ExampleMVVM

class MockCSSimpleInputViewModelDelegate: CSSimpleInputViewModelDelegate {
    var errorShown = false

    func showAlertViewController(title: String, message: String) {
        errorShown = true
    }
}

class CSSimpleInputViewModelTest: XCTestCase {
    func testTextFieldIsValidated() {
        var states: [CSSimpleInputViewModelState] = []

        let delegate = MockCSSimpleInputViewModelDelegate()

        let viewModel = CSSimpleInputViewModel(delegate: delegate) { state in
            states.append(state)
        }

        viewModel.myTextFieldChanged(text: "")
        XCTAssertEqual(states.last?.myTextFieldText, "")
        XCTAssertEqual(states.last?.myButtonIsEnabled, false)

        viewModel.myTextFieldChanged(text: "tESt")
        XCTAssertEqual(states.last?.myTextFieldText, "test")
        XCTAssertEqual(states.last?.myButtonIsEnabled, false)

        viewModel.myTextFieldChanged(text: "tESting")
        XCTAssertEqual(states.last?.myTextFieldText, "testing")
        XCTAssertEqual(states.last?.myButtonIsEnabled, true)
    }
}
