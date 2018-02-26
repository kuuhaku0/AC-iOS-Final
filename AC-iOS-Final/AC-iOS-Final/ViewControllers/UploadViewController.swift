//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import AVFoundation

class UploadViewController: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var cameraButtonItem: UIButton! {
        didSet {
            cameraButtonItem.backgroundColor = UIColor.lightGray
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        guard let image = currentSelectedImage else { print("don't have an image"); return }
        DBService.manager.newPost(body: textView.text, image: image)
        showAlert(title: "Success", message: "Posted")
        selectedImage = nil
        textView.text = "description"
    }
    
    private let imagePickerController = UIImagePickerController()
    private var currentSelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            cameraButtonItem.isEnabled = false
        }
    }

    @IBAction func showPhotoLibrary(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        checkAVAuthorization()
    }
    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showImagePicker()
                } else {
                    print("not granted")
                }
            })
        case .authorized:
            print("authorized")
            showImagePicker()
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        }
    }
    
    private func showImagePicker() {
        imagePickerController.modalPresentationStyle = .overCurrentContext
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        selectedImage.image = image
        currentSelectedImage = selectedImage.image
        dismiss(animated: true, completion: nil)
    }
}
