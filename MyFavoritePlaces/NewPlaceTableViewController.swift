//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by asbul on 29.06.2022.
//

import UIKit
import PhotosUI

final class NewPlaceTableViewController: UITableViewController {

    @IBOutlet weak var imageOfPlace: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .actionSheet
            )

            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker()
            }
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.choosePHPicker()
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)

            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
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

// MARK: - Work with Image
extension NewPlaceTableViewController: UIImagePickerControllerDelegate {
    private func chooseImagePicker() {
        let source = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        <#code#>
    }

    private func choosePHPicker() {
        let configuration = PHPickerConfiguration()
        let phPicker = PHPickerViewController(configuration: configuration)
        present(phPicker, animated: true)
    }
}
