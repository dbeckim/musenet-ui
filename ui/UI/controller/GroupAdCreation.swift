//
//  GroupAdCreation.swift
//  UI
//
//  Created by Austin Batistoni on 12/5/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//
import QuartzCore
import UIKit

struct Group{
    var groupName = ""
    var groupId = ""
}

class GroupAdCreation: BaseVC, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var groupIn: UITextField!
    
    @IBOutlet weak var instrumentsIn: UIPickerView!
   
    @IBOutlet weak var genresIn: UIPickerView!
    @IBOutlet weak var lookingForIn: UITextField!
    
  
    @IBOutlet weak var descriptionIn: UITextField!
    
    
    //Genres to pick from
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk","Funk","Hardcore","Hip Hop", "Jazz", "Latin","Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    //Instruments to pick from
    var instrumentData: [String] = ["Guitar","Bass","Drums"]
    
    //Array to store selected genre(s) both to print to user and to be stored in database for future
    var selectedGenres = String()
    var selectedInstruments = String()
    
    var groups = [Group]()
    
    var group_id = ""
    
    @IBAction func SubmitGroupAd(_ sender: AnyObject) {
        
        if groupIn.text! == "" {
            self.createAlert(title: "Attention", message: "Please select a group for your ad")
        }else if lookingForIn.text! == "" {
            self.createAlert(title: "Attention", message: "Please specify what you are looking for")
        }else if descriptionIn.text! == "" {
            createAlert(title: "Attention", message: "Please fill in a description")
        }else{
            let json: [String: Any] = [
                "description":descriptionIn.text!,
                "looking_for" : lookingForIn.text!,
                //I dont think the API is accepting a list for genres so im sending the first member
                "genre" : selectedGenres,
                "instrument": selectedInstruments,
                ]
            let resp = post(action: "create_group_ad", json: json, with: ["group_id" : group_id])
            if self.handleResponse(statusCode: resp.statusCode!){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "The Hub") as! AdTableViewController
                
                myVC.passed["email"] = self.passed["email"]
                navigationController?.pushViewController(myVC, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        groupIn.inputView = pickerView
        
        
        loadGroups()
        //Genres and Instruments stuff
       genresIn.delegate = self
        instrumentsIn.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGroups() {
        let email = self.passed["email"]
        let resp = get(action: "get_group", searchBy: ["profile_email": email!])
        if (self.handleResponse(statusCode: resp.statusCode)) {
            if let groupsIn = resp.json! as? [[String : Any]] {
                for group in groupsIn {
                    groups.append(Group(groupName: group["name"] as! String, groupId: group["group_id"] as! String))
                }
            } else {
                let groupsIn = resp.json! as! [String : Any]
                groups.append(Group(groupName: groupsIn["name"] as! String, groupId: "\(groupsIn["group_id"]!)" ))
            }
        } else {
            self.segueProfile(email: self.passed["email"], segueName: "GroupAdCreated")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == self.instrumentsIn{
            return instrumentData.count
        }
        else if pickerView == self.genresIn{
            return genreData.count
        }
        else{
            return groups.count
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.instrumentsIn{
            return instrumentData[row]
        }
        else if pickerView == self.genresIn{
            return genreData[row]
        }
        else{
            return groups[row].groupName
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.instrumentsIn{
            self.selectedInstruments = instrumentData[row]
        }
        else if pickerView == self.genresIn{
            self.selectedGenres = genreData[row]
        }
        else{
            groupIn.text = groups[row].groupName
            group_id = groups[row].groupId
            
        }
        
    }
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//        if textField == self.groupIn {
//            self.dropDown.isHidden = false
//            //if you dont want the users to se the keyboard type:
//            
//            textField.endEditing(true)
//        }
//        
//    }


}
