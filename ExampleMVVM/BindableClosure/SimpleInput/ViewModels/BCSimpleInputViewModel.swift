//
//  BCSimpleInputViewModel.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/27/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import Foundation

protocol BCSimpleInputViewModelDelegate: class {
    func showAlertViewController(title: String, message: String)
}

class BCSimpleInputViewModel {
    // Outputs
    private(set) var myTextFieldText = Bindable("")
    private(set) var myButtonIsEnabled = Bindable(false)

    // Inputs
    var inputMyTextFieldText = "" {
        didSet {
            myTextFieldText.value = inputMyTextFieldText.lowercased()

            myButtonIsEnabled.value = myTextFieldText.value.count > 5
        }
    }

    weak var delegate: BCSimpleInputViewModelDelegate?

    init(delegate: BCSimpleInputViewModelDelegate) {
        self.delegate = delegate
    }

    func myTextFieldChanged(text: String?) {
        inputMyTextFieldText = text ?? ""
    }

    func myButtonTapped() {
        if !myButtonIsEnabled.value {
            delegate?.showAlertViewController(title: "Input Error", message: "Input must be more than 5 characters.")
            return
        }
        print(myTextFieldText.value)
    }
}
