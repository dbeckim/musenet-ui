//
//  Login.swift
//  UI
//
//  Created by Jonah Shechtman on 11/8/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class Login: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBAction func Login(_ sender: Any) {
        let jsonObject: [String: Any] = [
        "email": Username.text,
        "password": Password.text]
        
        let jsonData:Data
        do{
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData as Data
                as Data;               let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            print("json string = \(jsonString)")
            post(jsonObj: jsonData, action: "login"){(json) in
                if (type(of: json!) != Int.self){
                    DispatchQueue.main.async {
                        self.createAlert(title: "Success", message:"Login Successful.")
                    }
                    
                }else{
                    DispatchQueue.main.async() {
                        self.createAlert(title: "Error", message:"Unable to Login.")
                    }
                }
            }
            
            
        }
        catch _ {
            print("failed")
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"ok", style:UIAlertActionStyle.default, handler: {(action)in alert.dismiss(animated:true,completion:nil)}))
        self.present(alert, animated: true, completion:nil)
    }

}
