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

class GroupAdCreation: BaseVC, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var groupIn: UITextField!
    
    @IBOutlet weak var lookingForIn: UITextField!
    
    @IBOutlet weak var instrumentsIn: UITableView!
    @IBOutlet weak var genresIn: UITableView!
    @IBOutlet weak var descriptionIn: UITextField!
    
    
    //Genres to pick from
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk","Funk","Hardcore","Hip Hop", "Jazz", "Latin","Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    //Instruments to pick from
    var instrumentData: [String] = ["Guitar","Bass","Drums"]
    
    //Array to store selected genre(s) both to print to user and to be stored in database for future
    var selectedGenres = [String]()
    var selectedInstruments = [String]()
    
    //Array to keep track of which genres are "checked" by the user.
    var checkedCellsGenres = [Bool](repeating: false, count: 17)
    var checkedCellsInstruments = [Bool](repeating:false, count:3)
    
    
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
                "genre" : selectedGenres[0],
                "instrument": selectedInstruments[0],
                ]
            let resp = post(action: "create_group_ad", json: json, with: ["group_id" : group_id])
            if self.handleResponse(statusCode: resp.statusCode!){
                self.performSegue(withIdentifier: "GroupAdCreated", sender: self)
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
        self.genresIn.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        genresIn.dataSource = self
        genresIn.delegate = self
        
        self.instrumentsIn.register(UITableViewCell.self, forCellReuseIdentifier: "cellInst")
        instrumentsIn.dataSource = self
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
        
        return groups.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups[row].groupName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupIn.text = groups[row].groupName
        group_id = groups[row].groupId
        
    }
    
    //Initializes the number of rows in the tableview as the number of objects in genre list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.genresIn{
            count =  self.genreData.count
        } else if tableView == self.instrumentsIn{
            count = self.instrumentData.count
        }
        
        return count!
    }
    //Initializes values for the table view cells corresponding to items in the genre list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.genresIn{
            cell = self.genresIn.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
            
            cell!.textLabel!.text = self.genreData[indexPath.row]
            
            if !checkedCellsGenres[indexPath.row] {
                cell!.accessoryType = .none
            } else if checkedCellsGenres[indexPath.row] {
                cell!.accessoryType = .checkmark
            }
            
            
        } else if tableView == self.instrumentsIn{
            cell = self.instrumentsIn.dequeueReusableCell(withIdentifier: "cellInst") as UITableViewCell!
            
            cell!.textLabel!.text = self.instrumentData[indexPath.row]
            
            if !checkedCellsInstruments[indexPath.row] {
                cell!.accessoryType = .none
            } else if checkedCellsInstruments[indexPath.row] {
                cell!.accessoryType = .checkmark
            }
            
            
            
        }
        return cell!
    }
    /*
     Handles user selection of tableView cells. Chosen genres should be updated each time the
     user selects a cell. The genreLabel will be updated with the selected or unselected value(s).
     Check mark toggled for selecting/unselecting of cells
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.genresIn{
            let genre = genreData[indexPath.row]
            
            if let cell = tableView.cellForRow(at: indexPath) {
                /*
                 If there is already a checkmark, remove checkmark from the cell, set checked = false
                 in checked array and remove genre from selected genres array
                 */
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    checkedCellsGenres[indexPath.row] = false
                    
                    if let index = selectedGenres.index(of: genre){
                        selectedGenres.remove(at: index)
                    }
                    
                    /*
                     If no checkmark, add checkmark to cell, set checked = true in checked array, and
                     append selected genre to array of selected genres
                     */
                } else {
                    cell.accessoryType = .checkmark
                    checkedCellsGenres[indexPath.row] = true
                    selectedGenres.append(genre)
                    
                }
            }
            
        } else {
            let instrument = instrumentData[indexPath.row]
            
            if let cell = tableView.cellForRow(at: indexPath) {
                /*
                 If there is already a checkmark, remove checkmark from the cell, set checked = false
                 in checked array and remove genre from selected genres array
                 */
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    checkedCellsInstruments[indexPath.row] = false
                    
                    if let index = selectedInstruments.index(of: instrument){
                        selectedInstruments.remove(at: index)
                    }
                    
                    /*
                     If no checkmark, add checkmark to cell, set checked = true in checked array, and
                     append selected genre to array of selected genres
                     */
                } else {
                    cell.accessoryType = .checkmark
                    checkedCellsInstruments[indexPath.row] = true
                    selectedInstruments.append(instrument)
                    
                }
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
}
