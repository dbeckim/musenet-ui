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

class GroupAdCreation: BaseVC, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var groupIn: UITextField!
    
    @IBOutlet weak var lookingForIn: UITextField!
    @IBOutlet weak var instrumentIn: UITextField!
    @IBOutlet weak var genreIn: UITextField!
    @IBOutlet weak var descriptionIn: UITextField!
    
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
                "genre" : genreIn.text!,
                "instrument": instrumentIn.text!,
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGroups(){
        let email = self.passed["email"]
        let resp = get(action: "get_group", searchBy: ["profile_email": email!])
        print(resp)
        if let groupsIn = resp.json! as? [[String : Any]]{
        
            for group in groupsIn{
                groups.append(Group(groupName: group["name"] as! String, groupId: group["group_id"] as! String))
            }
        }else{
            let groupsIn = resp.json! as! [String : Any]
            groups.append(Group(groupName: groupsIn["name"] as! String, groupId: "\(groupsIn["group_id"]!)" ))
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
        
        return groups.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups[row].groupName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupIn.text = groups[row].groupName
        group_id = groups[row].groupId
        
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
