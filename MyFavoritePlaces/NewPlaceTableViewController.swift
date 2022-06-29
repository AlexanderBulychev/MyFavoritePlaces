//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by asbul on 29.06.2022.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {

        } else {
            view.endEditing(true)
        }
    }
}

// MARK: - UI Table View Delegate
extension NewPlaceTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.becomeFirstResponder()
        return true
    }
}
