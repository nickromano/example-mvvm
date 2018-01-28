//
//  ClosureSimpleInputViewModel.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/27/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import Foundation

struct CSSimpleInputViewModelState {
    var myTextFieldText: String
    var myButtonIsEnabled: Bool
}

protocol CSSimpleInputViewModelDelegate: class {
    func showAlertViewController(title: String, message: String)
}

class CSSimpleInputViewModel {
    private(set) var state = CSSimpleInputViewModelState(myTextFieldText: "", myButtonIsEnabled: false) {
        didSet {
            self.callback(state)
        }
    }

    let callback: (CSSimpleInputViewModelState) -> Void

    private var inputTextFieldText = "" {
        didSet {
            state.myTextFieldText = inputTextFieldText.lowercased()

            state.myButtonIsEnabled = state.myTextFieldText.count > 5
        }
    }

    weak var delegate: CSSimpleInputViewModelDelegate?

    init(delegate: CSSimpleInputViewModelDelegate, callback: @escaping (CSSimpleInputViewModelState) -> Void) {
        self.delegate = delegate
        self.callback = callback
        self.callback(state)
    }

    func myTextFieldChanged(text: String?) {
        inputTextFieldText = text ?? ""
    }

    func myButtonTapped() {
        if !state.myButtonIsEnabled {
            delegate?.showAlertViewController(title: "Input Error", message: "Input must be more than 5 characters.")
            return
        }
        print(state.myTextFieldText)
    }
}
