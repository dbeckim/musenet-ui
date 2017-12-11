//
//  AdCreation.swift
//  UI
//
//  Created by Austin Batistoni on 12/4/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class AdCreation: BaseVC, UIPickerViewDelegate, UIPickerViewDataSource{

    var email = ""
    
    @IBOutlet weak var LookingForIn: UITextField!
    @IBOutlet weak var instrumentsIn: UIPickerView!
    @IBOutlet weak var genresIn: UIPickerView!
    @IBOutlet weak var DescriptionIn: UITextField!
    
    //Genres to pick from
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk","Funk","Hardcore","Hip Hop", "Jazz", "Latin","Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    //Instruments to pick from
    var instrumentData: [String] = ["Guitar","Bass","Drums"]
    
    //selected genre/instrument
    var selectedGenres = String()
    var selectedInstruments = String()
    
    //Roles picker view Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:Int) -> String? {
        if pickerView == self.genresIn{
            return genreData[row]
        }
        else{
            return instrumentData[row]
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.genresIn{
            return genreData.count
        }
        else{
            return instrumentData.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.genresIn{
            self.selectedGenres = genreData[row]
        }
        else{
            self.selectedInstruments = instrumentData[row]
        }
        //self.roleIn = roles[row]
    }
    
    @IBAction func SubmitAd(_ sender: AnyObject) {
        
        if LookingForIn.text! == "" {
            self.createAlert(title: "Attention", message: "Please specifiy what you are looking for.")
        }else if DescriptionIn.text! == "" {
            self.createAlert(title: "Attention", message: "Please fill in a description.")
        }else{
            
            
            let json: [String: Any] = [
                "description":DescriptionIn.text!,
                "looking_for" : LookingForIn.text!,
                "genre" : selectedGenres,
                "instrument": selectedInstruments,
                ]
            let resp = post(action: "create_profile_ad", json: json, with: ["email": email])
            if self.handleResponse(statusCode: resp.statusCode!){
                self.segueProfile(email: self.passed["email"], segueName: "AdCreated")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email = self.passed["email"] as! String
        //Genres and Instruments stuff
        instrumentsIn.delegate = self
        genresIn.delegate = self
        
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
