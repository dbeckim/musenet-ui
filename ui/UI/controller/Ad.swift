//
//  Ad.swift
//  theHub
//
//  Created by Austin Batistoni on 11/19/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//

import UIKit

/**
 This class contains the information for an Ad cell for the 
 app's main hub. Includes simple constructor for a new Ad object.
 **/

class Ad: NSObject {
    var role : String = "role name"
    var lookingFor : String = "what they are looking for"
    var location : String = "their location"
    
    init(role: String, lookingFor: String, location: String){
        self.role = role
        self.lookingFor = lookingFor
        self.location = location
    }
    
}
