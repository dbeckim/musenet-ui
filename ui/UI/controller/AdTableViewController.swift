//
//  AdTableViewController.swift
//  theHub
//
//  Created by Austin Batistoni on 11/19/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//

import UIKit

class AdTableViewController: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBAction func CreateAd(_ sender: AnyObject) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "CreateAd") as! AdCreation
        
        myVC.profileEmail = self.profileEmail
        navigationController?.pushViewController(myVC, animated: true)
    }
    @IBAction func hubToProfile(_ sender: AnyObject) {
        segueProfile(email: self.profileEmail, segueName: "hubToProfile")
    }
    
    var ads = [Ad]()
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewDidLoad()
        
        loadAds()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadAds() {
        
        //For now, load all ads without filtering by role, looking for, etc.
        let adResp = get(action: "get_ads")
        let adsIn = adResp.json! as! [[String: Any]]
        for ad in adsIn {
            //Distinguish between a group ad and a profile ad by whether "email" or "group_id" is filled in for the ad
            if let email = ad["email"] as? String {
                let profileResp = get(action: "get_profile", searchBy: ["email": email])
                //load in the profile associated with the ad
                let profile = profileResp.json! as! [String: Any]
                //Add a new ad object to the table
                ads.append(Ad(role: profile["role"] as! String, lookingFor: ad["looking_for"]! as! String, location: profile["location"] as! String, contactEmail: email, adDescription: ad["description"] as! String))
            }else{
                let groupResp = get(action: "get_group", searchBy: ["group_id": "\(ad["group_id"]!)"])
                //load in the group associated with the ad
                let group = groupResp.json! as! [String: Any]
                //Add a new ad object to the table
                ads.append(Ad(role: "Band", lookingFor: ad["looking_for"]! as! String, location: group["location"] as! String, contactEmail: group["email"] as! String, adDescription: ad["description"] as! String))
            }
            
        }
        
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
        cell.contactEmail.text = ad.contactEmail
        cell.adDescription.text = ad.adDescription
        cell.adDescription.adjustsFontSizeToFitWidth = true
        cell.location.adjustsFontSizeToFitWidth = true
        cell.location.textAlignment = .right
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    

    
}
