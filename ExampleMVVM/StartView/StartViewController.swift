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
    case simpleInputKVO
    case simpleInputClosure

    var title: String {
        switch self {
        case .simpleInputKVO, .simpleInputClosure:
            return "Simple Input"
        }
    }

    var viewController: UIViewController {
        switch self {
        case .simpleInputKVO:
            return KVOSimpleInputViewController()
        case .simpleInputClosure:
            return CSSimpleInputViewController()
        }
    }
}

enum TableViewSection {
    case kvo
    case closureState

    var rows: [TableViewRow] {
        switch self {
        case .kvo:
            return [.simpleInputKVO]
        case .closureState:
            return [.simpleInputClosure]
        }
    }

    var titleForHeader: String {
        switch self {
        case .kvo:
            return "KVO"
        case .closureState:
            return "Closure State"
        }
    }
}

class StartViewController: UITableViewController {
    let sections: [TableViewSection] = [.kvo, .closureState]

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

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].titleForHeader
    }
}
