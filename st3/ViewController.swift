//
//  ViewController.swift
//  GenrePicker
//
//  Created by Austin Batistoni on 9/26/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//

import UIKit

/*
 This program creates an alternative to UIPickerView to be used in Musician's Network App.
 Allows user to pick as many genres as they desire, and displays the chosen genres to the user.
 Chosen genres saved in an array for future database/other use.
 */
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var genreLabel: UILabel!
    
    //Data for the tableview - List of genres
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk", "Funk", "Hardcore",
                           "Hip Hop", "Jazz", "Latin", "Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    
    //Array to keep track of which genres are "checked" by the user.
    var checkedCells = [Bool](repeating: false, count: 17)
    
    //Array to store selected genre(s) both to print to user and to be stored in database for future
    var selectedGenres = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registers cell object as a part of tableview as "cell"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        genreLabel.text = "Pick a genre."
        genreLabel.font = genreLabel.font.withSize(50)
        genreLabel.textAlignment = .center
        genreLabel.minimumScaleFactor = 0.1
        genreLabel.adjustsFontSizeToFitWidth = true //allows label font to rescale depending on size of array
    }
    
    //Initializes the number of rows in the tableview as the number of objects in genre list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genreData.count;
    }
    
    //Initializes values for the table view cells corresponding to items in the genre list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        cell.textLabel?.text = self.genreData[indexPath.row]
        
        if !checkedCells[indexPath.row] {
            cell.accessoryType = .none
        } else if checkedCells[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    /*
     Handles user selection of tableView cells. Chosen genres should be updated each time the
     user selects a cell. The genreLabel will be updated with the selected or unselected value(s).
     Check mark toggled for selecting/unselecting of cells
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = genreData[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) {
            /*
             If there is already a checkmark, remove checkmark from the cell, set checked = false
             in checked array and remove genre from selected genres array
             */
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                checkedCells[indexPath.row] = false
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
                checkedCells[indexPath.row] = true
                selectedGenres.append(genre)
                
            }
        }
        
        //Sets genreLabel element to selected genres array separated by comma
        genreLabel.text = selectedGenres.joined(separator: ", ")
        
        //Defaults to a message if no genres are selected
        if (!checkedCells.contains(true)){
            genreLabel.text = "Pick a genre."
        }
    }
    

    
}


