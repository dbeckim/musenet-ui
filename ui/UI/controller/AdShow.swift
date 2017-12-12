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
    var editable = false
    
    @IBOutlet weak var adEditButton: UIButton!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DescLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var ContactLabel: UILabel!
    
    @IBOutlet weak var BackToPostsButton: UIButton!
   
   
    
    @IBAction func EditAd(_ sender: AnyObject) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "EditAd") as! EditAd
        
        
        myVC.ad = ad
        navigationController?.pushViewController(myVC, animated: true)
    }

    override func viewDidLoad() {
        print(editable)
        if editable{
            adEditButton.isHidden = false
        }else{
            adEditButton.isHidden = true
        }
        super.viewDidLoad()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(editable)
        if editable{
            adEditButton.isHidden = false
        }else{
            adEditButton.isHidden = true
        }
        super.viewDidLoad()
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
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
