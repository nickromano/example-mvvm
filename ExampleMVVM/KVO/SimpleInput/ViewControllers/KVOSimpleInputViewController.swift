//
//  SimpleInputViewController.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/26/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import UIKit

class KVOSimpleInputViewController: UIViewController {
    @IBOutlet weak var myTextField: UITextField! {
        didSet {
            myTextField.delegate = self
            myTextField.addTarget(self, action: #selector(myTextFieldChanged), for: UIControlEvents.editingChanged)
        }
    }
    @IBOutlet weak var myButton: UIButton!

    @objc var viewModel: KVOSimpleInputViewModel!

    var observers: [NSKeyValueObservation?] = []

    init() {
        super.init(nibName: KVOSimpleInputViewController.className, bundle: nil)

        viewModel = KVOSimpleInputViewModel(delegate: self)

        title = "Simple Input"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented, use init() instead")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        myTextField.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        myTextField.text = viewModel.myTextFieldText  // Set the inital
        observers.append(observe(\.viewModel.myTextFieldText) { [weak self] (_, _) in
            self?.myTextField.text = self?.viewModel.myTextFieldText  // Update on changes
        })

        myButton.isEnabled = viewModel.myButtonIsEnabled  // Set the initial
        observers.append(observe(\.viewModel.myButtonIsEnabled) { [weak self] (_, _) in
            guard let myButtonIsEnabled = self?.viewModel.myButtonIsEnabled else {
                return
            }
            self?.myButton.isEnabled = myButtonIsEnabled  // Update on changes
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Remove observers - only necessary on builds targeting < iOS 10
        observers.forEach { observer in
            observer?.invalidate()
        }
        observers = []
    }

    @objc func myTextFieldChanged() {
        viewModel.inputMyTextFieldText = myTextField.text ?? ""
    }

    @IBAction func myButtonTapped(_ sender: Any) {
        viewModel.myButtonTapped()
    }
}

extension KVOSimpleInputViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myButtonTapped(textField)
        return true
    }
}

extension KVOSimpleInputViewController: KVOSimpleInputViewModelDelegate {
    func showAlertViewController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
