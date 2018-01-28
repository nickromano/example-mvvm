//
//  SimpleInputViewModelTest.swift
//  ExampleMVVMTests
//
//  Created by Nicholas Romano on 1/26/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import XCTest
@testable import ExampleMVVM

class MockKVOSimpleInputViewModelDelegate: KVOSimpleInputViewModelDelegate {
    var errorShown = false

    func showAlertViewController(title: String, message: String) {
        errorShown = true
    }
}

class KVOSimpleInputViewModelTest: XCTestCase {
    func testTextFieldIsValidated() {
        let delgate = MockKVOSimpleInputViewModelDelegate()

        let viewModel = KVOSimpleInputViewModel(delegate: delgate)

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
