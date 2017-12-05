//
//  GroupCreation.swift
//  GroupCreation
//
//  Created by MN Team on 11/30/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class GroupCreation: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    //group genres
    var groupGenreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk", "Funk", "Hardcore", "Hip Hop", "Jazz", "Latin", "Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    
    //Array to keep track of which group genres are "checked" by the user.
    var checkedCellsGroupGenres = [Bool](repeating: false, count: 17)
    
    //Array to store selected genre(s) both to print to user and to be stored in database for the guture
    var selectedGroupGenres = [String]()
    
    //IBOutlets
    @IBOutlet weak var groupNameIn: UITextField!
    @IBOutlet weak var LocationIn: UITextField!
    @IBOutlet weak var groupBioIn: UITextField!
    @IBOutlet weak var groupGenreIn: UITableView!
    
    @IBAction func Submit(_ sender: Any) {
        //Json object to pass to HTTP request, deals with validation
        
        if (groupNameIn.text! == "") {
            self.createAlert(title: "Attention", message: "Group Name required")
        } else if (groupBioIn.text! == "") {
            self.createAlert(title: "Attention", message: "Group Bio required")
        } else if (LocationIn.text! == "") {
            self.createAlert(title: "Attention", message: "Location required")
        } else {
            print (selectedGroupGenres)
            let json: [String: Any] = [
                "group name": groupNameIn.text!,
                "location": LocationIn.text!,
                "group bio": groupBioIn.text!,
                "genres": selectedGroupGenres
                ]
            let resp = post(action: "create_group_profile", json: json)
            if self.handleResponse(statusCode: resp.statusCode) {
                
            }
        }
    }
    
    
    
    //Initializes the number of rows in the tableview as the number of objects in group genre list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.groupGenreIn {
            count = self.groupGenreData.count
        }
        
        return count!
    }
    
    
    
    //Initializes values for the table view cells corresponding to items in the group genre list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.groupGenreIn{
            cell = self.groupGenreIn.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
            
            cell!.textLabel!.text = self.groupGenreData[indexPath.row]
            
            if !checkedCellsGroupGenres[indexPath.row] {
                cell!.accessoryType = .none
            } else if checkedCellsGroupGenres[indexPath.row] {
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
        if tableView == self.groupGenreIn{
            let genre = groupGenreData[indexPath.row]
            
            if let cell = tableView.cellForRow(at: indexPath) {
                /*
                 If there is already a checkmark, remove checkmark from the cell, set checked = false
                 in checked array and remove genre from selected genres array
                 */
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    checkedCellsGroupGenres[indexPath.row] = false
                    
                    if let index = selectedGroupGenres.index(of: genre){
                        selectedGroupGenres.remove(at: index)
                    }
                    
                    /*
                     If no checkmark, add checkmark to cell, set checked = true in checked array, and
                     append selected genre to array of selected genres
                     */
                } else {
                    cell.accessoryType = .checkmark
                    checkedCellsGroupGenres[indexPath.row] = true
                    selectedGroupGenres.append(genre)
                    
                }
            }
            
        } 

    }
    
}


