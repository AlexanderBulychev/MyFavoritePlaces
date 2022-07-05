//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by asbul on 29.06.2022.
//

import UIKit
import PhotosUI

final class NewPlaceTableViewController: UITableViewController {

    var newPlace = Place()
    var imageIsChanged = false

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.newPlace.savePlaces()
        }

        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false

        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

        placeDescription.text = "Add your comment here"
    }

    func saveNewPlace() {
        var image: UIImage?
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }

//        newPlace = Place(
//            name: placeName.text!,
//            location: placeLocation.text,
//            type: placeType.text,
//            image: image,
//            description: placeDescription.text,
//            restaurantImage: nil
//        )
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
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
        saveButton.isEnabled = placeName.text?.isEmpty ?? false ? false : true
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

        imageIsChanged = true
        dismiss(animated: true)
    }
}
