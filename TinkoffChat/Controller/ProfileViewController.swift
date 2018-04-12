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
    @IBOutlet var editProfileButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var setProfileImageView: UIView!
    @IBOutlet weak var setProfileImageButton: UIButton!
    
    @IBOutlet var gcdButton: UIButton!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let gcdManager = GCDManager()
    var profileData: Profile?
    var editMode: Bool = false
        
    let profileDefaultData = Profile(
        name: "Maxim Kuznetsov",
        desc: "Coding with passion, closing bugs with agression, getting obsession in release regression...",
        photo: UIImage(named: "placeholder-user"))
    
    override func viewDidLoad() {
        
        print(getDocumentsDirectory())
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
        
        title = "My Profile"
        
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        
        setProfileImageView.layer.cornerRadius = 40
        
        loadProfile()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func changeEditMode(_ sender: UIBarButtonItem) {
        editMode = !editMode
        updateUI()
    }
    
    @IBAction func saveProfileGCD(_ sender: Any) {
        
        if let userName = nameTextField.text {
            activityIndicator.startAnimating()
            let newProfile = Profile(name: userName, desc: descriptionTextView.text, photo: profileImageView.image)
            StorageManager.save()
            gcdManager.save(profile: newProfile) { [weak self] (success) in
                DispatchQueue.main.async { self?.activityIndicator.stopAnimating() }
                if success {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Данные сохранены",
                                                      message: "",
                                                      preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK",
                                                      style: UIAlertActionStyle.default,
                                                      handler: {action in
                                                        self?.editMode = false
                                                        self?.loadProfile()
                        }))
                        self?.present(alert, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ошибка",
                                                      message: "Не удалось сохранить данные",
                                                      preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Повторить",
                                                      style: UIAlertActionStyle.default,
                                                      handler: { action in
                                                        self?.saveProfileGCD(sender)
                                                        
                        }))
                        alert.addAction(UIAlertAction(title: "ОК",
                                                      style: UIAlertActionStyle.cancel,
                                                      handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    @IBAction func setProfileImageAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
        pickPhoto()
    }
    
    @IBAction func closeProfile() {
        dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !text.isEmpty && profileData?.name != text {
            unlockSavingButtons()
        } else {
            lockSavingButtons()
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
            unlockSavingButtons()
        } else {
            lockSavingButtons()
        }
        

        return true
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isShowing = notification.name == .UIKeyboardWillShow
            
            self.view.frame.origin.y = isShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func updateUI() {
        if let profileData = profileData {
            profileImageView.image = profileData.photo
            nameTextField.text = profileData.name
            descriptionTextView.text = profileData.desc
        }
        
        if (editMode) {
            editProfileButton.title = "Undo"
            
            nameTextField.borderStyle = .roundedRect
            nameTextField.layer.borderWidth = 2
            nameTextField.layer.borderColor = UIColor.yellow.cgColor
            nameTextField.isEnabled = true
            nameTextField.becomeFirstResponder()
            
            descriptionTextView.isEditable = true
            descriptionTextView.isSelectable = true
            descriptionTextView.layer.borderWidth = 2
            descriptionTextView.layer.borderColor = UIColor.yellow.cgColor
        } else {
            editProfileButton.title = "Edit"
            
            nameTextField.borderStyle = .none
            nameTextField.layer.borderWidth = 0
            nameTextField.layer.borderColor = UIColor.clear.cgColor
            nameTextField.isEnabled = false
            
            descriptionTextView.isEditable = false
            descriptionTextView.isSelectable = false
            descriptionTextView.layer.borderWidth = 0
            descriptionTextView.layer.borderColor = UIColor.clear.cgColor
            
            lockSavingButtons()
        }
    }
    
    func lockSavingButtons() {
        gcdButton.isEnabled = false
    }
    
    func unlockSavingButtons() {
        gcdButton.isEnabled = true
    }
    
    private func loadProfile() {
        gcdManager.load { [weak self] (profile) in
            DispatchQueue.main.async {
                if let profile = profile {
                    self?.profileData = profile
                } else {
                    self?.profileData = self?.profileDefaultData
                }
                self?.updateUI()
            }
        }
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
        
        let profileImage = info[UIImagePickerControllerEditedImage] as? UIImage
        if let image = profileImage {
            profileImageView.image = image
            unlockSavingButtons()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

