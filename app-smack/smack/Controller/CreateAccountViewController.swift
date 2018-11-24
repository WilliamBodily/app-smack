//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by William Bodily on 11/23/18.
//  Copyright © 2018 William Bodily. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }

}
