//
//  AdShow.swift
//  UI
//
//  Created by Austin Batistoni on 12/6/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class AdShow: UIViewController {

    var ad: Ad?
    
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var ContactLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(ad!.adDescription)
        print(ad!.name)
        role.text = ad!.role + " looking for " + ad!.lookingFor
        role.textAlignment = .center
        role.font = UIFont.boldSystemFont(ofSize: 25.0)
        NameLabel.text = ad!.name
        NameLabel.textAlignment = .center
        DescLabel.text = ad!.adDescription
        DescLabel.textAlignment = .center
        LocationLabel.text = ad!.location
        LocationLabel.textAlignment = .center
        ContactLabel.text = ad!.contactEmail
        ContactLabel.textAlignment = .center
        
        
        // Do any additional setup after loading the view.
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
