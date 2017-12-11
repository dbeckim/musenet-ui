//
//  AdTypeSelect.swift
//  UI
//
//  Created by Austin Batistoni on 12/5/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class AdTypeSelect: BaseVC {

    @IBAction func Next(_ sender: AnyObject) {
        if profileAdButton.isSelected{
            let myVC = storyboard?.instantiateViewController(withIdentifier: "CreateAd") as! AdCreation
            
            myVC.passed["email"] = self.passed["email"]
            navigationController?.pushViewController(myVC, animated: true)
        }else{
            let myVC = storyboard?.instantiateViewController(withIdentifier: "CreateGroupAd") as! GroupAdCreation
            
            myVC.passed["email"] = self.passed["email"]
            navigationController?.pushViewController(myVC, animated: true)
        }
    }
    @IBOutlet weak var groupAdButton: AdTypeButton!
    @IBOutlet weak var profileAdButton: AdTypeButton!
    
    override func awakeFromNib() {
        self.view.layoutIfNeeded()
        
        profileAdButton.isSelected = true
        groupAdButton.isSelected = false
    }
    
    override func viewDidLoad() {
        self.passed["email"] = self.passed["email"]
        profileAdButton?.alternateButton = [groupAdButton!]
        groupAdButton?.alternateButton = [profileAdButton!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
