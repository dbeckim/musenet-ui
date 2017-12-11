//
//  AdTableViewController.swift
//  theHub
//
//  Created by Austin Batistoni on 11/19/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//

import UIKit

class AdTableViewController: BaseVC, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var TheHubHeader: UIToolbar!

    @IBOutlet weak var FindMatchesBar: UIToolbar!
    
    @IBOutlet weak var ResultsLabel: UIBarButtonItem!
    
    var matching = false
    
    @IBAction func FindMatches(_ sender: AnyObject) {
        matching = !matching
        if matching{
            loadAds(match: true)
            FindMatchesButton.title = "All Results"
            ResultsLabel.title = "Your Matches:"
        }else{
            loadAds(match: false)
            FindMatchesButton.title = "Find Matches"
            ResultsLabel.title = "All Results:"
        }
        
        
    }
    @IBOutlet weak var FindMatchesButton: UIBarButtonItem!
    
    @IBAction func AdTypeSelection(_ sender: AnyObject) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "AdTypeSelection") as! AdTypeSelect
        
        myVC.passed["email"] = self.passed["email"]
        navigationController?.pushViewController(myVC, animated: true)
    }
   
    @IBOutlet var tableView: UITableView!
    
    
    @IBAction func hubToProfile(_ sender: AnyObject) {
        segueProfile(email: self.passed["email"], segueName: "HubToProfile")
    }
    
    var ads = [Ad]()
    
    
    
    
    override func viewDidLoad() {

    

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewDidLoad()
        
        loadAds(match : false)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadAds(match : Bool) {
        ads.removeAll()
        var adResp = get(action : "get_ads")
        //For now, load all ads without filtering by role, looking for, etc.
        if match{
            adResp = get(action: "get_ads", searchBy: ["email" : self.passed["email"]!])
        }
        print(adResp.json)
        
        if adResp.json != nil{
            let adsIn = adResp.json! as? [[String: Any]]
            for ad in adsIn! {
            //Distinguish between a group ad and a profile ad by whether "email" or "group_id" is filled in for the ad
                if let email = ad["email"] as? String {
                    let profileResp = get(action: "get_profile", searchBy: ["email": email])
                    //load in the profile associated with the ad
                    let profile = profileResp.json! as! [String: Any]
                    //Add a new ad object to the table
                    ads.append(Ad(role: profile["role"] as! String, lookingFor: ad["looking_for"]! as! String, location: profile["location"] as! String, contactEmail: email, adDescription: ad["description"] as! String, name: profile["name"] as! String))
                }else{
                    let groupResp = get(action: "get_group", searchBy: ["group_id": "\(ad["group_id"]!)"])
                    //load in the group associated with the ad
                    let group = groupResp.json! as! [String: Any]
                    //Add a new ad object to the table
                    ads.append(Ad(role: "Band", lookingFor: ad["looking_for"]! as! String, location: group["location"] as! String, contactEmail: group["email"] as! String, adDescription: ad["description"] as! String, name: group["name"] as! String))
                }
            }
        }else{
            createAlert(title: "Error", message: "No ads found.")
        }
        //print(adResp.json!)
        tableView.reloadData()

        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return FindMatchesBar
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TheHubHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
        
        cell.role.text = ad.role + " looking for a " + ad.lookingFor
        cell.role.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.location.text = ad.location
        cell.contactEmail.text = ad.contactEmail
        cell.adDescription.text = ad.adDescription
        cell.adDescription.adjustsFontSizeToFitWidth = true
        cell.location.adjustsFontSizeToFitWidth = true
        cell.location.textAlignment = .right
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let ad = ads[indexPath.row]
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ShowAd") as! AdShow
        
        myVC.ad = ad 
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    

    
}
