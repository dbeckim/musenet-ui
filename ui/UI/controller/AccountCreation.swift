//
//  AccountCreation.swift
//  AccountCreation
//
//  Created by Kevin S Delay on 10/17/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//Account Creation page, upon submit creates JSON object
//Json object sent to the http requet method

import UIKit




class AccountCreation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //IBOutlets

    @IBOutlet weak var EmailIn: UITextField!
    @IBOutlet weak var PasswordIn: UITextField!
    @IBOutlet weak var NameIn: UITextField!
    @IBOutlet weak var PasswordConfirm: UITextField!
    @IBOutlet weak var LocationIn: UITextField!
    @IBOutlet weak var BioIn: UITextField!
    @IBOutlet weak var PhoneIn: UITextField!
    @IBOutlet weak var GenreIn: UITableView!
    @IBOutlet weak var InstrumentsIn: UITableView!
    @IBOutlet weak var RoleIn: UITextField!
    //Action for submit
    @IBAction func Submit(_ sender: Any) {
       
        //***********Need to send request testing if email is already in DB***************
        
       
        //Creating Json object to pass to HTTP Request, need more validation for inputs
        if PasswordIn.text == PasswordConfirm.text{
            let jsonObject: [String: Any] = [
                "email":EmailIn.text,
                "name" : NameIn.text,
                //***Hash this***
                "password" : PasswordIn.text,
                "role": RoleIn.text,
                "location": LocationIn.text,
                "bio":BioIn.text,
                
            ]
            let jsonData:Data
            do{
                jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData as Data
  as Data;               let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
                print("json string = \(jsonString)")
                 post(jsonObj: jsonData, action: "create_profile")
            }
            catch _ {
                print("failed")
            }
            
        }
        else{
            createAlert(title:"Attention", message: "Passwords do not match!")
        }
       
        
        
        
        
    }
    //Genres to pick from
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk","Funk","Hardcore","Hip Hop", "Jazz", "Latin",
                               "Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    //Instruments to pick from
    var instrumentData: [String] = ["Guitar","Bass","Drums"]
    //Array to keep track of which genres are "checked" by the user.
    var checkedCellsGenres = [Bool](repeating: false, count: 17)
    var checkedCellsInstruments = [Bool](repeating:false, count:3)
    
    //Array to store selected genre(s) both to print to user and to be stored in database for future
    var selectedGenres = [String]()
    var selectedInstruments = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Registers cell object as a part of tableview as "cell" for instruments and genres
        self.GenreIn.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        GenreIn.dataSource = self
        GenreIn.delegate = self
        
        self.InstrumentsIn.register(UITableViewCell.self, forCellReuseIdentifier: "cellInst")
        InstrumentsIn.dataSource = self
        InstrumentsIn.delegate = self
    
    }
    //Initializes the number of rows in the tableview as the number of objects in genre list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Count to be returned
        var count:Int?
        //For Genres
        if tableView == self.GenreIn{
            count =  self.genreData.count
        }
        //For Instruments
        else if tableView == self.InstrumentsIn{
            count = self.instrumentData.count
        }
        return count!
    }
   
    
    //Initializes values for the table view cells corresponding to items in the genre list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        //For Genres
        if tableView == self.GenreIn{
         cell = self.GenreIn.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        cell!.textLabel!.text = self.genreData[indexPath.row]
        
        if !checkedCellsGenres[indexPath.row] {
            cell!.accessoryType = .none
        } else if checkedCellsGenres[indexPath.row] {
            cell!.accessoryType = .checkmark
        }
        
        
        }
        //For Instruments
        else if tableView == self.InstrumentsIn{
            cell = self.InstrumentsIn.dequeueReusableCell(withIdentifier: "cellInst") as UITableViewCell!
            
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
        if tableView == self.GenreIn{
            let genre = genreData[indexPath.row]
            
            if let cell = tableView.cellForRow(at: indexPath) {
                /*
                 If there is already a checkmark, remove checkmark from the cell, set checked = false
                 in checked array and remove genre from selected genres array
                 */
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    checkedCellsGenres[indexPath.row] = false
                    print("You unselected \(genre)!")
                    
                    if let index = selectedGenres.index(of: genre){
                        selectedGenres.remove(at: index)
                    }
                    
                    /*
                     If no checkmark, add checkmark to cell, set checked = true in checked array, and
                     append selected genre to array of selected genres
                     */
                } else {
                    print("You selected \(genre)!")
                    cell.accessoryType = .checkmark
                    checkedCellsGenres[indexPath.row] = true
                    selectedGenres.append(genre)
                    
                }
            }
            
            //Sets genreLabel element to selected genres array separated by comma
            //genreLabel.text = selectedGenres.joined(separator: ", ")
            
            //Defaults to a message if no genres are selected
            
        }
    //Checking of cells for the instruments table
        
    else {
    let instrument = instrumentData[indexPath.row]
    
    if let cell = tableView.cellForRow(at: indexPath) {
    /*
     If there is already a checkmark, remove checkmark from the cell, set checked = false
     in checked array and remove genre from selected genres array
     */
    if cell.accessoryType == .checkmark {
    cell.accessoryType = .none
    checkedCellsInstruments[indexPath.row] = false
    print("You unselected \(instrument)!")
    
    if let index = selectedInstruments.index(of: instrument){
    selectedInstruments.remove(at: index)
    }
    
    /*
     If no checkmark, add checkmark to cell, set checked = true in checked array, and
     append selected genre to array of selected genres
     */
    } else {
    print("You selected \(instrument)!")
    cell.accessoryType = .checkmark
    checkedCellsInstruments[indexPath.row] = true
    selectedInstruments.append(instrument)
    
    }
    }
    
    //Sets genreLabel element to selected genres array separated by comma
    //genreLabel.text = selectedGenres.joined(separator: ", ")
    
    //Defaults to a message if no genres are selected
    
    }
    }
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"ok", style:UIAlertActionStyle.default, handler: {(action)in alert.dismiss(animated:true,completion:nil)}))
        self.present(alert, animated: true, completion:nil)
    }


}
