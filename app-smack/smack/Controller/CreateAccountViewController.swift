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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTextField.text , emailTextField.text != "" else { return }
        guard let password = passwordTextField.text , passwordTextField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if (success) {
                print("Registered user successfully!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if (success) {
                        print("Logged in user successfully!", AuthService.instance.authToken)
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
