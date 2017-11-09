//
//  Login.swift
//  UI
//
//  Created by MN Team on 11/8/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//

import UIKit

class Login: BaseVC {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func register(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToCreation", sender: self)
    }
    
    @IBAction func submit(_ sender: Any) {
        let json: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        
        post(action: "login", json: json)  { resp in
            if self.handleResponse(statusCode: resp.statusCode) {
                self.segueProfile(email: json["email"], segueName: "LoginToDisplay")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
