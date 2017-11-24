//
//  Ad.swift
//  UI
//
//  Created by Austin Batistoni on 11/20/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

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
