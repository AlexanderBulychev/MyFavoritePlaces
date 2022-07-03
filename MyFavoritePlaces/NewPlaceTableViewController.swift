//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by asbul on 29.06.2022.
//

import UIKit
import PhotosUI

final class NewPlaceTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeComment: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        placeComment.text = "Add your comment here"
        saveButton.isEnabled = false
        tableView.tableFooterView = UIView()

        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
    }

    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .actionSheet
            )

            let photoIcon = #imageLiteral(resourceName: "camera")
            let imageIcon = #imageLiteral(resourceName: "photo")

            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker()
            }
            camera.setValue(photoIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.choosePHPicker()
            }
            photo.setValue(imageIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")

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

    @objc
    private func textFieldChanged() {
        saveButton.isEnabled = placeName.text?.isEmpty ?? <#default value#> ? false : true
    }
}

extension NewPlaceTableViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.becomeFirstResponder()
        return true
    }
}

// MARK: - Work with Photo

extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func chooseImagePicker() {
        let source = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        dismiss(animated: true)

    }
}

// MARK: - Work with Images

extension NewPlaceTableViewController: PHPickerViewControllerDelegate {

    private func choosePHPicker() {
        let configuration = PHPickerConfiguration()
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.placeImage.image = image
                        self.placeImage.contentMode = .scaleAspectFill
                        self.placeImage.clipsToBounds = true
                    }
                }
            }
        }
        dismiss(animated: true)
    }
}
