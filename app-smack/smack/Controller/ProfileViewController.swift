//
//  ProfileViewController.swift
//  Smack
//
//  Created by William Bodily on 3/5/19.
//  Copyright © 2019 William Bodily. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userNamePressed(_ sender: Any) {
        self.userNameButton.isHidden = true
        self.userNameText.isHidden = false
        self.updateButton.isHidden = false
        self.cancelButton.isHidden = false
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        self.userNameButton.isHidden = false
        self.userNameText.isHidden = true
        self.updateButton.isHidden = true
        self.cancelButton.isHidden = true
        
        if self.userNameText.text != "" {
            guard let name = self.userNameText.text else { return }
            AuthService.instance.updateUserById(name: name, completion: { (success) in
                if (success) {
                    self.userNameLabel.text = UserDataService.instance.name
                    NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGE, object: nil)
                }
            })
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.userNameText.text = ""
        self.userNameButton.isHidden = false
        self.userNameText.isHidden = true
        self.updateButton.isHidden = true
        self.cancelButton.isHidden = true
    }
    
    func setupView() {
        self.userNameButton.isHidden = false
        self.userNameText.isHidden = true
        self.updateButton.isHidden = true
        self.cancelButton.isHidden = true
        userProfileImage.image = UIImage(named: UserDataService.instance.avatarName)
        userProfileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        userNameLabel.text = UserDataService.instance.name
        userEmailLabel.text = UserDataService.instance.email
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.closeTap(_:)))
        backgroundView.addGestureRecognizer(closeTouch)
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
