//
//  BaseVC.swift
//  UI
//
//  Created by MN Team on 11/7/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//

import UIKit
import CoreData

class BaseVC: UIViewController, UITextFieldDelegate {
    //email for this session
    var passed = [String: Any]()
    
    func segueProfile(email: Any!, segueName: String) {
        let email = email as! String
        
        let resp = get(action: "get_profile", searchBy: ["email": email])
        if self.handleResponse(statusCode: resp.statusCode) {
            self.passed = resp.json as! [String: Any]
            
            self.performSegue(withIdentifier: segueName, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
            
        case "CreationToDisplay":
            let dest = segue.destination as! ProfileDisplay
            dest.passed = self.passed
            break
            
        case "LoginToDisplay":
            let dest = segue.destination as! ProfileDisplay
            dest.passed = self.passed
            break
        
        case "HubToProfile":
            let dest = segue.destination as! ProfileDisplay
            dest.passed = self.passed
            break
        
        case "ProfileToHub":
            let dest = segue.destination as! AdTableViewController
            dest.passed = self.passed
            break
            
        case "LoginToHub":
            let dest = segue.destination as! AdTableViewController
            dest.passed = self.passed
            break
        
        case "GroupAdCreated":
            let dest = segue.destination as! AdTableViewController
            dest.passed = self.passed
            break
            
        case "AdCreated":
            let dest = segue.destination as! AdTableViewController
            dest.passed = self.passed
            break
            
        default:
            break
    
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    func handleResponse(statusCode: Int!) -> Bool {
        switch (statusCode) {
            
        case 200:
            return true
            
        case 400:
            self.createAlert(title: "Invalid", message: "Invalid parameters.")
            break
            
        case 404:
            self.createAlert(title: "Invalid", message: "Does not exist")
            break
            
        case 409:
            self.createAlert(title: "Exists",  message: "Already exists")
            break
            
        case 500:
            self.createAlert(title: "Error",   message: "Unable to process your request.")
            break
            
        default:
            self.createAlert(title: "Unknown", message: "An unknown error occured with the request.")
            break
        }
        
        return false
    }
    
    func createAlert (title:String, message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"ok", style:UIAlertActionStyle.default, handler: {(action)in alert.dismiss(animated:true,completion:nil)}))
            self.present(alert, animated: true, completion:nil)
        }
    }

}
