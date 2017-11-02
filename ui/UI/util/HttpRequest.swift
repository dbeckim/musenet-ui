//
//  HttpRequest.swift
//  GenrePicker
//
//  Created by Austin Batistoni on 10/24/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//
import Foundation

/*
 HTTP GET request to server side API. Action is what will be queried from database, and
 searchBy is the value of the index the query is performed on. The JSON encoded data is
 returned by the closure.
 Example: Action = "get_profile&email", searchBy = "example@example.com"
 */
public func get(action : String, searchBy : String, completion: @escaping (Any?) -> Void){
    let url = URL(string: "http://bmckalla.w3.uvm.edu/api/api.py?action=\(action)=\(searchBy)")!
    //New HTTP GET reqeust with URL string
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    //Create HTTP request task
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        
        //Error handler for HTTP request
        let httpResponse = response as? HTTPURLResponse
        if(httpResponse!.statusCode != 200){
            completion(httpResponse!.statusCode)
            
            //HTTP request is successful
        }else{
            do {
                //Serialize data as JSON object and return via closure
                if let json : Any = try JSONSerialization.jsonObject(with: data!, options: []){
                    completion(json)
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    task.resume()
}

/*
 HTTP POST request to server side API. jsonObj is the JSON Object being passed to the
 database, and action determines which database will be added to.
 */
public func post(jsonObj : Data?, action: String, completion: @escaping (Any?) -> Void){
    let url = URL(string: "http://bmckalla.w3.uvm.edu/api/api.py?action=" + action)!
    //New HTTP POST request with URL string
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    //Add the json object to body of the http request
    request.httpBody = jsonObj
    
    //Create HTTP request task
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        
        
        //Error handler for HTTP reques
        let httpResponse = response as? HTTPURLResponse
        if(httpResponse!.statusCode != 200){
            completion(httpResponse!.statusCode)
            
        }else{
            //Prints success if post is successful
            let data = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            completion(data!)
        }
    }
    
    task.resume()
    
}
