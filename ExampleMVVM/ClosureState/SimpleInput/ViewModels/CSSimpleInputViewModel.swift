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

    init(callback: @escaping (CSSimpleInputViewModelState) -> Void) {
        self.callback = callback
        self.callback(state)
    }

    func myTextFieldChanged(text: String?) {
        inputTextFieldText = text ?? ""
    }

    func myButtonTapped(completion: (ButtonTappedResult) -> Void) {
        if !state.myButtonIsEnabled {
            completion(.error(title: "Input Error", message: "Input must be more than 5 characters."))
            return
        }
        print(state.myTextFieldText)
        completion(.saved)
    }
}
