//
//  ProfileDisplay.swift
//  Musicians Network
//
//  Created by MN Team on 10/16/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//

import UIKit

class GroupDisplay: BaseVC {
    //Real ugly and bare minimum, working on it ;)
    
    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var displayBio: UILabel!
    
    @IBOutlet weak var displayLocation: UILabel!
    
    @IBOutlet weak var displayEmail: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        groupName.text = self.passed["name"] as? String
        displayBio.text = self.passed["bio"] as? String
        displayLocation.text = self.passed["location"]as? String
        displayEmail.text = self.passed["email"] as? String
        print (self.passed)
        //name.text = self.passed["name"] as? String
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
