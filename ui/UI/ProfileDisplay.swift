//
//  ProfileDisplay.swift
//  Musicians Network
//
//  Created by Test Person on 10/16/17.
//  Copyright © 2017 UVM Comp Sci. All rights reserved.
//

import UIKit


class ProfileDisplay: UIViewController {
    
    /*///////////////////////////////
     goes in previous View Controller's prepareForSegue method:
     
     var nextController = segue.destination as! SecondViewController
     secondController.MyString = pickerLabel.text!
     
     ////////////////////////////////
     goes in this View Controller:
     
     var MyString = String();
     ////////////////////////////////
     a.	email
     b.	name
     c.	bio
     d.	phone
     e.	genres
     f.	instruments
     g.	profile_picture as a path on the server
     genres/instruments will be a list
     everything encoded as a json file
     */
    
    @IBOutlet weak var email: UILabel?
    @IBOutlet weak var password: UILabel? //definitely not used
    @IBOutlet weak var name: UILabel? //used
    @IBOutlet weak var location: UILabel? //used
    @IBOutlet weak var bio: UILabel? //used
    @IBOutlet weak var phone: UILabel?
    @IBOutlet weak var genre: UILabel? //used
    @IBOutlet weak var instruments:UILabel? //used
    @IBOutlet weak var role: UILabel?
    
    var nameString = String()
    
    var decoded: NSDictionary!
    
    //HTTP request
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     var secondController = segue.destination as! SecondViewController
     secondController.MyString = pickerLabel.text!
     }
     */
    
    override func viewDidLoad() {
        
        
        let jsonStuff: [String: String] = [
        "email":"dbeckim@uvm.edu",
        "name" : "Devin",
        //***Hash this***
        "password" : "password",
        "role": "Bass, Back-end",
        "genre": "Rap, Ska",
        "location": "Burlington, VT",
        "bio": "Have you ever had a dream that you, um, you had, your, you- you could, you’ll do, you- you wants, you, you could do so, you- you’ll do, you could- you, you want, you want them to do you so much you could do anything?"]
        
        do {
            
            if let json_data = try? JSONSerialization.data(withJSONObject: jsonStuff, options: .prettyPrinted) {
                self.decoded = try? JSONSerialization.jsonObject(with: json_data, options: []) as! NSDictionary
            }
        } catch {
            print("error")
        }
        
        for (key, val) in self.decoded {
            print("\(key):")
            print("\(val)")
            
            if("\(key):" == "name:"){
                self.name?.text = ("\(val)")
            }
            else if("\(key):" == "bio:"){
                self.bio?.text = ("\(val)")
            }
            else if("\(key):" == "location:"){
                self.location?.text = ("\(val)")
            }
            else if("\(key):" == "role:"){
                self.role?.text = ("\(val)")
            }
            
            
            
        }
        
        super.viewDidLoad()
        
        decodeJson()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func decodeJson() {
        print("Decoding.......wait.....")
        
         //var names = [String]()
 
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
