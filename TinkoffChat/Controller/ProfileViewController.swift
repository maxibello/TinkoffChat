//
//  ViewController.swift
//  TinkoffChat
//
//  Created by MacBookPro on 21/02/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var setProfileImageView: UIView!
    @IBOutlet weak var setProfileImageButton: UIButton!
    
    @IBOutlet var gcdButton: UIButton!
    @IBOutlet var operationButton: UIButton!
    
    var profileImage: UIImage?
    
    var profileData: Profile?
        
    let profileDefaultData = Profile(
        name: "Maxim Kuznetsov",
        desc: "Coding with passion, close bugs with agression, finding obsession in release regression...",
        photo: UIImage(named: "top_proger"))
    
    override func viewDidLoad() {
        title = "My Profile"
        
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        
        gcdButton.isEnabled = false
        operationButton.isEnabled = false
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        
        setProfileImageView.layer.cornerRadius = 40
        
        nameTextField.borderStyle = .none
        nameTextField.isEnabled = false
        
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = false
        
        profileData = loadProfile() ?? profileDefaultData
        updateUI()
    }
    
    func updateUI() {
        if let profileData = profileData {
            profileImageView.image = profileData.photo
            nameTextField.text = profileData.name
            descriptionTextView.text = profileData.desc
        }
    }
    
    @IBAction func startEditMode(_ sender: UIBarButtonItem) {
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.borderColor = UIColor.yellow.cgColor
        nameTextField.isEnabled = true
        nameTextField.becomeFirstResponder()
        
        descriptionTextView.isEditable = true
        descriptionTextView.isSelectable = true
        descriptionTextView.layer.borderWidth = 2
        descriptionTextView.layer.borderColor = UIColor.yellow.cgColor
    }
    
    @IBAction func saveProfileGCD(_ sender: Any) {
        saveProfile()
    }
    
    @IBAction func saveProfileOperation(_ sender: Any) {
    }
    
    
    @IBAction func setProfileImageAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
        pickPhoto()
    }
    
    @IBAction func closeProfile() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(#function)
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty && profileData?.name != text {
            gcdButton.isEnabled = true
            operationButton.isEnabled = true
        } else {
            gcdButton.isEnabled = false
            operationButton.isEnabled = false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        descriptionTextView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        let fullText = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        
        if !fullText.isEmpty && profileData?.desc != fullText {
            gcdButton.isEnabled = true
            operationButton.isEnabled = true
        } else {
            gcdButton.isEnabled = false
            operationButton.isEnabled = false
        }
        

        return true
    }
    
    private func saveProfile() {
        if let profileData = profileData {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(profileData, toFile: Profile.archiveURL.path)
            if isSuccessfulSave {
                print("Success")
            } else {
                print("Failed to save profile")
            }
        }
    }
    
    private func loadProfile() -> Profile? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Profile.archiveURL.path) as? Profile
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil,
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
        let takePhotoAction = UIAlertAction(title: "Take Photo",
                                            style: .default, handler:  { _ in self.takePhotoWithCamera() })
        alertController.addAction(takePhotoAction)
        let chooseFromLibraryAction = UIAlertAction(title:
            "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary() })
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        profileImage = info[UIImagePickerControllerEditedImage] as? UIImage
        if let image = profileImage {
            profileImageView.image = image
            profileData?.photo = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

