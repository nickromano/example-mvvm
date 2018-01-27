//
//  CSSimpleInputViewControllerTest.swift
//  ExampleMVVMTests
//
//  Created by Nicholas Romano on 1/27/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import XCTest
@testable import ExampleMVVM

class CSSimpleInputViewControllerTest: XCTestCase {
    let viewController = CSSimpleInputViewController()

    override func setUp() {
        super.setUp()

        UIApplication.shared.keyWindow?.rootViewController = viewController
    }

    func testViewControllerStartsAsEmptyAndDisabled() {
        XCTAssertEqual(viewController.myTextField.text, "")
        XCTAssertEqual(viewController.myButton.isEnabled, false)
    }

    func testViewControllerFormatsAndValidatesInput() {
        viewController.myTextField.insertText("tESt")
        XCTAssertEqual(viewController.myTextField.text, "test")
        XCTAssertEqual(viewController.myButton.isEnabled, false)
    }

    func testViewControllerAcceptsInputOverFiveCharacters() {
        viewController.myTextField.insertText("tESting")
        XCTAssertEqual(viewController.myTextField.text, "testing")
        XCTAssertEqual(viewController.myButton.isEnabled, true)
    }

    func testViewControllerDisablesButtonAfterRemovingCharacters() {
        viewController.myTextField.insertText("tESting")
        XCTAssertEqual(viewController.myTextField.text, "testing")
        XCTAssertEqual(viewController.myButton.isEnabled, true)

        viewController.myTextField.deleteBackward()
        viewController.myTextField.deleteBackward()
        viewController.myTextField.deleteBackward()
        viewController.myTextField.deleteBackward()
        XCTAssertEqual(viewController.myButton.isEnabled, false)
    }

    func testSubmitInput() {
        viewController.myTextField.insertText("tESting")

        viewController.myButton.sendActions(for: .touchUpInside)
        // Make sure an error alert isn't shown
        XCTAssertNil(viewController.presentedViewController)
    }

    func testSubmitOnInvalidInput() {
        viewController.myTextField.insertText("test")

        viewController.myButton.sendActions(for: .touchUpInside)
        // Make sure an error alert IS shown
        XCTAssertNotNil(viewController.presentedViewController)
    }
}
