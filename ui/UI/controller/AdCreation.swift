//
//  AdCreation.swift
//  UI
//
//  Created by Austin Batistoni on 12/4/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class AdCreation: BaseVC, UITableViewDelegate, UITableViewDataSource {

    var email = ""
    
    @IBOutlet weak var LookingForIn: UITextField!
    @IBOutlet weak var instrumentsIn: UITableView!
    @IBOutlet weak var genresIn: UITableView!
    @IBOutlet weak var DescriptionIn: UITextField!
    
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
    
    @IBAction func SubmitAd(_ sender: AnyObject) {
        
        if LookingForIn.text! == "" {
            self.createAlert(title: "Attention", message: "Please specifiy what you are looking for.")
        }else if DescriptionIn.text! == "" {
            self.createAlert(title: "Attention", message: "Please fill in a description.")
        }else{
            
            
            let json: [String: Any] = [
                "description":DescriptionIn.text!,
                "looking_for" : LookingForIn.text!,
                "genre" : selectedGenres[0],
                "instrument": selectedInstruments[0],
                ]
            let resp = post(action: "create_profile_ad", json: json, with: ["email": email])
            if self.handleResponse(statusCode: resp.statusCode!){
                self.segueProfile(email: self.passed["email"], segueName: "AdCreated")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email = self.passed["email"] as! String
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

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
