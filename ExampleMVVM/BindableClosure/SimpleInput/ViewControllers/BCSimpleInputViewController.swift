//
//  BCSimpleInputViewController.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/27/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import UIKit

class BCSimpleInputViewController: UIViewController {
    @IBOutlet weak var myTextField: UITextField! {
        didSet {
            myTextField.delegate = self
            myTextField.addTarget(self, action: #selector(myTextFieldChanged), for: UIControlEvents.editingChanged)
        }
    }
    @IBOutlet weak var myButton: UIButton!

    let viewModel = BCSimpleInputViewModel()

    init() {
        super.init(nibName: BCSimpleInputViewController.className, bundle: nil)

        title = "Simple Input"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented, use init() instead")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.myTextFieldText.bindAndFire { [weak self] text in
            self?.myTextField.text = text
        }

        viewModel.myButtonIsEnabled.bindAndFire { [weak self] isEnabled in
            self?.myButton.isEnabled = isEnabled
        }

        myTextField.becomeFirstResponder()
    }

    @objc func myTextFieldChanged() {
        viewModel.myTextFieldChanged(text: myTextField.text)
    }

    @IBAction func myButtonTapped(_ sender: Any) {
        viewModel.myButtonTapped { result in
            switch result {
            case .saved:
                break
            case .error(let title, let message):
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension BCSimpleInputViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myButtonTapped(textField)
        return true
    }
}
