//
//  AccountCreation.swift
//  AccountCreation
//
//  Created by MN Team on 10/17/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//

import UIKit
import CoreLocation
class AccountCreation: BaseVC, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let locationManager = CLLocationManager()
    
    //Genres to pick from
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk","Funk","Hardcore","Hip Hop", "Jazz", "Latin", "Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    //Instruments to pick from
    var instrumentData: [String] = ["Guitar","Bass","Drums"]
    
    //Array to keep track of which genres are "checked" by the user.
    var checkedCellsGenres = [Bool](repeating: false, count: 17)
    var checkedCellsInstruments = [Bool](repeating:false, count:3)
    
    //Array to store selected genre(s) both to print to user and to be stored in database for future
    var selectedGenres = [String]()
    var selectedInstruments = [String]()
    var chosenImage = UIImage()
    var roleIn = String()
    var locationCoords: String?
    let roles = ["Member","Producer","Hype-man"]
    
    //IBOutlets
    @IBOutlet weak var EmailIn: UITextField!
    @IBOutlet weak var PasswordIn: UITextField!
    @IBOutlet weak var PasswordConfirm: UITextField!
    @IBOutlet weak var NameIn: UITextField!
    
    @IBOutlet weak var rolesIn: UIPickerView!
    @IBOutlet weak var PhoneIn: UITextField!
    @IBOutlet weak var LocationIn: UITextField!
    @IBOutlet weak var BioIn: UITextField!
    @IBOutlet weak var InstrumentsIn: UITableView!
    @IBOutlet weak var GenresIn: UITableView!
    let imagePicker = UIImagePickerController()
    
    //Roles picker view Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:Int) -> String? {
        return roles[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.roleIn = roles[row]
    }
    
    //Grabs submitted image saves it into chosen image defined above
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]){
        self.chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    //handles a cancelled action i guess
    func imagePickerControllerDidCancel(_ imagePicker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //Add Picture action
    @IBAction func addPicture(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker,animated:true,completion: nil)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        locationCoords = ("\(locValue.latitude):\(locValue.longitude)")
        //print(locationCoords)
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationCoords = nil
    }
    
    @IBAction func submit(_ sender: Any) {
        
        //Creating Json object to pass to HTTP Request, need more validation for inputs
        if PasswordIn.text != PasswordConfirm.text && PasswordIn.text != "" {
            self.createAlert(title:"Attention", message: "Passwords do not match")
        } else if !(EmailIn.text!.contains("@")) {
            self.createAlert(title:"Attention", message: "Email invalid")
        } //else if (RoleIn.text! == "") {
            //self.createAlert(title: "Attention", message: "Role required")
         else if (LocationIn.text! == "") {
            self.createAlert(title: "Attention", message: "Location required")
        } else {
            var json: [String: Any] = [
                "email":EmailIn.text!,
                "name" : NameIn.text!,
                "password" : PasswordIn.text!,
                "role": self.roleIn,
                "location": locationCoords!,
                "bio":BioIn.text!,
                "phone":PhoneIn.text!,
                "genres":selectedGenres,
                "instruments":selectedInstruments
                
            ]
            
            let resp = post(action: "create_profile", json: json)
            
            //testing of the picture submission stuff not working ATM
            print(resp)
            if self.handleResponse(statusCode: resp.statusCode) {
                let temp = EncodeImage(image: self.chosenImage)
                let picJson: [String: Any]=[
                    "base64":temp,
                    "main":true]
                //print(picJson["base64"])
              self.passed = json
                let resp2 = post(action:"add_profile_picture",json:picJson, with: ["email": EmailIn.text!])
                print (resp2)
                if resp2.ok{
                    self.base64 = temp
                    
                }
                self.segueProfile(email: json["email"], segueName: "CreationToDisplay")
            }
        }
        
        
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.performSegue(withIdentifier: "CreationToLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Location Stuff
        rolesIn.delegate = self
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined{
            self.locationManager.requestWhenInUseAuthorization()
            locationCoords = nil
        }
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
            
           // locationManager.stopUpdatingLocation()
        }
        PhoneIn.delegate = self
        //Image Picker delegate Setting to self didnt work but this does?
        
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        PasswordIn.isSecureTextEntry = true
        PasswordConfirm.isSecureTextEntry = true
        
        // Do any additional setup after loading the view, typically from a nib.
        //Registers cell object as a part of tableview as "cell" for instruments and genres
        self.GenresIn.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        GenresIn.dataSource = self
        GenresIn.delegate = self
        
        self.InstrumentsIn.register(UITableViewCell.self, forCellReuseIdentifier: "cellInst")
        InstrumentsIn.dataSource = self
        InstrumentsIn.delegate = self
        //Number field is a number pad
        PhoneIn.keyboardType = UIKeyboardType.numberPad
        
    }
    
    //Initializes the number of rows in the tableview as the number of objects in genre list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.GenresIn{
            count =  self.genreData.count
        } else if tableView == self.InstrumentsIn{
            count = self.instrumentData.count
        }
        
        return count!
    }
    
    
    //Initializes values for the table view cells corresponding to items in the genre list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.GenresIn{
            cell = self.GenresIn.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
            
            cell!.textLabel!.text = self.genreData[indexPath.row]
            
            if !checkedCellsGenres[indexPath.row] {
                cell!.accessoryType = .none
            } else if checkedCellsGenres[indexPath.row] {
                cell!.accessoryType = .checkmark
            }
            
            
        } else if tableView == self.InstrumentsIn{
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
        if tableView == self.GenresIn{
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
    }
}
