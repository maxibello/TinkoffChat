//
//  ViewController.swift
//  TinkoffChat
//
//  Created by MacBookPro on 21/02/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var setNewImageButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        // Do any additional setup after loading the view, typically from a nib.
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        
        setNewImageButton.layer.cornerRadius = 40
        setNewImageButton.imageView?.contentMode = .scaleAspectFit
        setNewImageButton.clipsToBounds = true
        
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.black.cgColor
        
        descriptionLabel.sizeToFit()
    }
    
    @IBAction func setProfileImageAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
    }
    
    @IBAction func editAction(_ sender: Any) {
        let button = sender as? UIButton
        
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
    
}

