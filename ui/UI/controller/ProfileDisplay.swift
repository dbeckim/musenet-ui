//
//  ProfileDisplay.swift
//  Musicians Network
//
//  Created by MN Team on 10/16/17.
//  Copyright © 2017 UVM CEMS All rights reserved.
//
import UIKit

class ProfileDisplay: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var role: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var instruments: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editLocation: UITextField!
    @IBOutlet weak var editPhone: UITextField!
    @IBOutlet weak var editRole: UITextField!
    @IBOutlet weak var editGenre: UITextField!
    @IBOutlet weak var editInstruments: UITextField!
    @IBOutlet weak var editBio: UITextField!
    
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var editprof: UIButton!
    
    @IBOutlet weak var editProPic: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    @IBAction func logout(_ sender: Any) {
        self.performSegue(withIdentifier: "DisplayToLogin", sender: self)
    }
    
    @IBAction func profileToHub(_ sender: Any) {
        self.segueProfile(email: self.passed["email"], segueName: "ProfileToHub")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.textAlignment = .center
        imagePicker.delegate = self
        
        editProPic.isHidden = true
        editprof.layer.borderWidth=2.0
        editprof.layer.cornerRadius = 5
        editprof.layer.borderWidth = 1
        editprof.layer.borderColor=UIColor.lightGray.cgColor
       
        update.layer.borderWidth=2.0
        update.layer.cornerRadius = 5
        update.layer.borderWidth = 1
        update.layer.borderColor=UIColor.lightGray.cgColor
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        name.text = self.passed["name"] as? String
        email.text = self.passed["email"] as? String
        role.text = self.passed["role"] as? String
        phone.text = self.passed["phone"] as? String
        location.text = self.passed["location"] as? String
        bio.text = self.passed["bio"] as? String
        
        
        if let genre_list = (self.passed["genres"] as? [String]) {
            genres.text = genre_list.joined(separator: ", ")
        } else {
            genres.text = "None"
        }
        
        if let instr_list = (self.passed["instruments"] as? [String]) {
            instruments.text = instr_list.joined(separator: ", ")
        } else {
            instruments.text = "None"
        }
        //let resp = get(action:"get_profile_picture", searchBy:["email":self.passed["email"]!])
        //print(resp)
        //let picture = resp.json as! [[String:Any]]
        //Ωprint(picture[0]["base64"] as! String)

       // self.profilePic.image  = DecodeImage(fromBase64: picture[0]["base64"] as! String)
        
        editName.isHidden = true
        editLocation.isHidden = true
        editPhone.isHidden = true
        editRole.isHidden = true
        editBio.isHidden = true
        
        update.isHidden = true
        
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2;
        profilePic.clipsToBounds = true;
        profilePic.layer.borderWidth = 4
        profilePic.layer.borderColor = UIColor.black.cgColor
        
        name.textAlignment = NSTextAlignment.center;
    }
    
    @IBAction func getUserPhoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            profilePic.contentMode = .scaleAspectFit
            profilePic.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func editProfile(_ sender: Any) {
        update.isHidden = false
        editProPic.isHidden = false
        
        name.textAlignment = .left
        //updateButton.isHidden = false
        
        editName.text = name.text
        editLocation.text = location.text
        editPhone.text = phone.text
        editRole.text = role.text
        editBio.text = bio.text
        
        name.textAlignment = NSTextAlignment.left;
        name.font = name.font.withSize(17);
        
        name.text = "Name: "
        location.text = "Location: "
        phone.text = "Phone #: "
        role.text = "Role: "
        bio.text = "Bio: "
        
        editName.isHidden = false
        editLocation.isHidden = false
        editPhone.isHidden = false
        editRole.isHidden = false
        editBio.isHidden = false
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        
        editName.isHidden = true
        editLocation.isHidden = true
        editPhone.isHidden = true
        editRole.isHidden = true
        editBio.isHidden = true
        editProPic.isHidden = true
        
        name.textAlignment = .center;
        name.font = name.font.withSize(25);

        name.text = editName.text
        location.text = editLocation.text
        phone.text = editPhone.text
        role.text = editRole.text
        bio.text = editBio.text
        
        let b64Pic = EncodeImage(image: profilePic.image!)
        
        let picJson: [String: Any] = [
            "base64" : b64Pic
        ]
        
        //EDIT PROFILE POST
        let editjson: [String: Any] = [
            "name" : editName.text!,
            "role": editRole.text!,
            "location": editLocation.text!,
            "bio": editBio.text!,
            "phone": editPhone.text!
        ]
        
        let response = post(action: "edit_profile", json: editjson,with: ["email": email.text!])
        
        if (self.handleResponse(statusCode: response.statusCode)) {
            name.text = editName.text
            location.text = editLocation.text
            phone.text = editPhone.text
            role.text = editRole.text
            bio.text = editBio.text
        }
        
        //ADD PRO PIC POST
        let picResp = post(action: "add_profile_picture", json: picJson,with:["email": email.text!])
        print(picResp.statusCode!)
        
        update.isHidden = true
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
