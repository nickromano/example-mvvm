//
//  ViewModel.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/26/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import Foundation

protocol KVOSimpleInputViewModelDelegate: class {
    func showAlertViewController(title: String, message: String)
}

class KVOSimpleInputViewModel: NSObject {
    // Outputs
    @objc dynamic private(set) var myTextFieldText = ""
    @objc dynamic private(set) var myButtonIsEnabled = false

    // Inputs
    var inputMyTextFieldText = "" {
        didSet {
            myTextFieldText = inputMyTextFieldText.lowercased()

            myButtonIsEnabled = myTextFieldText.count > 5
        }
    }

    weak var delegate: KVOSimpleInputViewModelDelegate?

    init(delegate: KVOSimpleInputViewModelDelegate) {
        self.delegate = delegate
    }

    func myButtonTapped() {
        if !myButtonIsEnabled {
            delegate?.showAlertViewController(title: "Input Error", message: "Input must be more than 5 characters.")
            return
        }
        print(myTextFieldText)
    }
}
