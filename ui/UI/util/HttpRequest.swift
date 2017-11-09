//
//  HttpRequest.swift
//  GenrePicker
//
//  Created by Austin Batistoni on 10/24/17.
//  Copyright © 2017 Austin Batistoni. All rights reserved.
//
import Foundation
import Just

var url = String("http://bmckalla.w3.uvm.edu/api/api.py")!

/*
 HTTP GET request to server side API. Action is what will be queried from database, and
 searchBy is the value of the index the query is performed on. The JSON encoded data is
 returned by the closure.
 Example: Action = "get_profile&email", searchBy = "example@example.com"
 
 Uses Just library
*/
    
public func get(action : String, searchBy : String, value : String) -> Just.HTTPResult {
    return Just.get(url, params: ["action": action, searchBy: value])
}

/*
 HTTP POST request to server side API. jsonObj is the JSON Object being passed to the
 database, and action determines which database will be added to.
*/
public func post(action: String, json: [String: Any]) -> Just.HTTPResult {
    return Just.post(url, params: ["action": action], json: json)
}
