//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by William Bodily on 11/23/18.
//  Copyright © 2018 William Bodily. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var waitIndicator: UIActivityIndicatorView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var backgroundColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && backgroundColor == nil {
                userImageView.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func setupView() {
        
        waitIndicator.isHidden = true
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER_TEXT])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER_TEXT])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : PURPLE_PLACEHOLDER_TEXT])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        waitIndicator.isHidden = false
        waitIndicator.startAnimating()
        
        guard let name = usernameTextField.text , usernameTextField.text != "" else { return }
        guard let email = emailTextField.text , emailTextField.text != "" else { return }
        guard let password = passwordTextField.text , passwordTextField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if (success) {
                print("Registered user successfully!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if (success) {
                        print("Logged in user successfully!", AuthService.instance.authToken)
                        print("User Name: \(name)/nAvatar Name: \(self.avatarName)/nAvatar Color: \(self.avatarColor)")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion:  { (success) in
                            if (success) {
                                self.waitIndicator.isHidden = true
                                self.waitIndicator.stopAnimating()
                                print("User Name: \(UserDataService.instance.name)/nAvatar Name: \(UserDataService.instance.avatarName)/nAvatar Color: \(UserDataService.instance.avatarColor)")
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBackgroundColorPressed(_ sender: Any) {
        
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        
        backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        avatarColor = "[\(red), \(green), \(blue), 1]"
        UIView.animate(withDuration: 0.2) {
            self.userImageView.backgroundColor = self.backgroundColor
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }

}
