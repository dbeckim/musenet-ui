//
//  AdTableViewCell.swift
//  theHub
//
//  Created by Austin Batistoni on 11/19/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var lookingFor: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var adDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
