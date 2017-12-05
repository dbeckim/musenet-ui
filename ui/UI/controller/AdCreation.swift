//
//  AdCreation.swift
//  UI
//
//  Created by Austin Batistoni on 12/4/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class AdCreation: BaseVC {

    var email = ""
    
    @IBOutlet weak var LookingForIn: UITextField!
    @IBOutlet weak var InstrumentIn: UITextField!
    @IBOutlet weak var GenreIn: UITextField!
    @IBOutlet weak var DescriptionIn: UITextField!
    
    @IBAction func SubmitAd(_ sender: AnyObject) {
        let json: [String: Any] = [
            "description":DescriptionIn.text!,
            "looking_for" : LookingForIn.text!,
            "genre" : GenreIn.text!,
            "instrument": InstrumentIn.text!,
        ]
        let resp = post(action: "create_profile_ad", json: json, with: ["email": email])
        print(resp)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email = self.profileEmail
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
