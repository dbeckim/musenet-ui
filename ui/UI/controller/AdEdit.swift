//
//  EditAd.swift
//  UI
//
//  Created by Austin Batistoni on 12/12/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import UIKit

class EditAd: BaseVC, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var instrumentEdit: UIPickerView!
    @IBOutlet weak var genreEdit: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lookingForEdit: UITextField!
    @IBOutlet weak var descriptionEdit: UITextField!
    
    
    @IBAction func UpdateAd(_ sender: AnyObject) {
        ad?.adDescription = descriptionEdit.text!
        ad?.genre = chosenGenre
        ad?.instrument = chosenInstrument
        ad?.lookingFor = lookingForEdit.text!
        //EDIT PROFILE POST
        let editjson: [String: Any] = [
            "description": descriptionEdit.text!,
            "looking_for" : lookingForEdit.text!,
            //I dont think the API is accepting a list for genres so im sending the first member
            "genre" : chosenGenre,
            "instrument": chosenInstrument
        ]
        
        let response = post(action: "edit_ad", json: editjson,with: ["ad_id": ad!.id])
        if handleResponse(statusCode: response.statusCode!){
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
            
//            let myVC = storyboard?.instantiateViewController(withIdentifier: "ShowAd") as! AdShow
//            myVC.editable = true
//            myVC.ad = self.ad
//            navigationController?.pushViewController(myVC, animated: true)
            
            
        }
        
    }
    
    var chosenInstrument = ""
    var chosenGenre = ""
    
    var ad : Ad?
    
    var genreData: [String] = ["Blues", "Classical", "Country", "Electronic", "Emo", "Folk","Funk","Hardcore","Hip Hop", "Jazz", "Latin","Metal", "Pop", "Punk", "R&B", "Reggae", "Rock"]
    //Instruments to pick from
    var instrumentData: [String] = ["Guitar","Bass","Drums"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        nameLabel.text = ad!.name
        lookingForEdit.text = ad!.lookingFor
        
        descriptionEdit.text = ad!.adDescription
        
        instrumentEdit.delegate = self
        genreEdit.delegate = self
        
        
        
        //groupIn.inputView = pickerView
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == instrumentEdit{
            return instrumentData.count
        }
        else{
            return genreData.count
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.instrumentEdit{
            return instrumentData[row]
        }
        else{
            return genreData[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.instrumentEdit{
            self.chosenInstrument = instrumentData[row]
        }
        else if pickerView == self.genreEdit{
            self.chosenGenre = genreData[row]
        }
        
        
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
