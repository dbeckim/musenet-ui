//
//  BaseVC.swift
//  UI
//
//  Created by MN Team on 11/7/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    var passed = [String: Any]()
    
    func segueProfile(email: Any!, segueName: String) {
        let email = email as! String
        
        get(action: "get_profile", searchBy: "email", value: email) { resp in
            if self.handleResponse(statusCode: resp.statusCode) {
                self.passed = resp.json as! [String: Any]
                self.performSegue(withIdentifier: segueName, sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "CreateToDisplay":
            let dest = segue.destination as! ProfileDisplay
            dest.passed = self.passed
        case "LoginToDisplay":
            let dest = segue.destination as! ProfileDisplay
            dest.passed = self.passed
        default:
            break
        }
    }
    
    func handleResponse(statusCode: Int!) -> Bool {
        switch (statusCode) {
        case 200: return true
        case 400: self.createAlert(title: "Invalid", message: "Invalid parameters.")
        case 404: self.createAlert(title: "Invalid", message: "Profile does not exist")
        case 409: self.createAlert(title: "Exists",  message: "Profile with that email already exists")
        case 500: self.createAlert(title: "Error",   message: "Unable to process your request.")
        default:
            self.createAlert(title: "Unknown", message: "An unknown error occured with the request.")
            break
        }
        
        return false
    }
    
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"ok", style:UIAlertActionStyle.default, handler: {(action)in alert.dismiss(animated:true,completion:nil)}))
        self.present(alert, animated: true, completion:nil)
    }

}
