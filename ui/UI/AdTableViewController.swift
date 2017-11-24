//
//  AdTableViewController.swift
//  UI
//
//  Created by Austin Batistoni on 11/20/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class AdTableViewController: UITableViewController {
    
    var ads = [Ad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleAds()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadSampleAds() {
        let ad1 = Ad(role: "Musician", lookingFor: "Producer", location: "Burlington, VT")
        let ad2 = Ad(role: "Producer", lookingFor: "Bands", location: "Burlington, VT")
        let ad3 = Ad(role: "Venue", lookingFor: "Bands", location: "New York, NY")
        let ad4 = Ad(role: "Musician", lookingFor: "Band", location: "Tempe, AZ")
        let ad5 = Ad(role: "Band", lookingFor: "Drummer", location: "Park City, UT")
        let ad6 = Ad(role: "Band", lookingFor: "Bassist", location: "Boston, MA")
        let ad7 = Ad(role: "Band", lookingFor: "Gig", location: "San Francisco, CA")
        let ad8 = Ad(role: "Band", lookingFor: "Studio", location: "South Burlington, VT")
        
        ads += [ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8]
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ads.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AdTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AdTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let ad = ads[indexPath.row]
        
        cell.role.text = "Role: " + ad.role
        cell.lookingFor.text = "Looking for: " + ad.lookingFor
        cell.location.text = ad.location
        cell.location.adjustsFontSizeToFitWidth = true
        cell.location.textAlignment = .right
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

