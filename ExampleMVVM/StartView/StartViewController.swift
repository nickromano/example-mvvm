//
//  StartViewController.swift
//  ExampleMVVM
//
//  Created by Nicholas Romano on 1/26/18.
//  Copyright © 2018 Ten Minute Wait. All rights reserved.
//

import Foundation
import UIKit

enum TableViewRow {
    case simpleInput

    var title: String {
        switch self {
        case .simpleInput:
            return "Simple Input"
        }
    }

    var viewController: UIViewController {
        switch self {
        case .simpleInput:
            return SimpleInputViewController()
        }
    }
}

enum TableViewSection {
    case main

    var rows: [TableViewRow] {
        switch self {
        case .main:
            return [.simpleInput]
        }
    }
}

class StartViewController: UITableViewController {
    let sections: [TableViewSection] = [.main]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Examples"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath)

        let row = sections[indexPath.section].rows[indexPath.row]

        cell.textLabel?.text = row.title
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let row = sections[indexPath.section].rows[indexPath.row]
        navigationController?.pushViewController(row.viewController, animated: true)
    }
}
