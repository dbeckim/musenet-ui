//
//  Login.swift
//  UI
//
//  Created by MN Team on 11/8/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//

import UIKit
import CoreData

class Login: BaseVC {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rememberMe: CheckBox!
    
    @IBAction func register(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToCreation", sender: self)
    }
    
    @IBAction func submit(_ sender: Any) {
        let json: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        
        let resp = post(action: "login", json: json)
        if self.handleResponse(statusCode: resp.statusCode) {
            
            if rememberMe.isChecked {
                self.rememberMeCore(action: "delete")
                self.rememberMeCore(action: "save")
            } else {
                self.rememberMeCore(action: "delete")
            }
            
            self.segueProfile(email: json["email"], segueName: "LoginToDisplay")
        }
    }
    
    func rememberMeCore(action: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        switch(action) {
            
        case "save":
            let user = NSEntityDescription.insertNewObject(forEntityName: "RememberMe", into: context)
            
            user.setValue(email.text!, forKey: "email")
            user.setValue(password.text!, forKey: "password")
            
            do {
                try context.save()
            } catch {
                self.createAlert(title: "Error", message: "Could not save credentials")
            }
            break
            
        case "load":
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RememberMe")
            
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    let user = results[0] as! NSManagedObject
                    email.text = user.value(forKey: "email") as? String
                    password.text = user.value(forKey: "password") as? String
                    rememberMe.buttonClicked(sender: rememberMe)
                }
            } catch {
                return
            }
            break
            
        case "delete":
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RememberMe")
            
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    for user in results {
                        context.delete(user as! NSManagedObject)
                    }
                }
            } catch {
                return
            }
            break
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        self.rememberMeCore(action: "load")
    }
}
