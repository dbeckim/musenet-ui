//
//  AdTableViewController.swift
//  theHub
//
//  Created by Austin Batistoni on 11/19/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//

import UIKit

class AdTableViewController: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBAction func hubToProfile(_ sender: AnyObject) {
        segueProfile(email: self.profileEmail, segueName: "hubToProfile")
    }
    
    var ads = [Ad]()
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        //Just test data for now 
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ads.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AdTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AdTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let ad = ads[indexPath.row]
        
        cell.role.text = "Role: " + ad.role
        cell.lookingFor.text = "Looking for: " + ad.lookingFor
        cell.location.text = ad.location
        cell.location.adjustsFontSizeToFitWidth = true
        cell.location.textAlignment = .right
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    

    
}
