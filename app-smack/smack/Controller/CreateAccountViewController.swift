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
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = usernameTextField.text , usernameTextField.text != "" else { return }
        guard let email = emailTextField.text , emailTextField.text != "" else { return }
        guard let password = passwordTextField.text , passwordTextField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if (success) {
                print("Registered user successfully!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if (success) {
                        print("Logged in user successfully!", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion:  { (success) in
                            if (success) {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func generateBackgroundColorPressed(_ sender: Any) {
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }

}
