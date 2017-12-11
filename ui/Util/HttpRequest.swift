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
 HTTP GET request to server side API.
 
 - Uses Just library
 - Parameters:
    - action: what server side function you wish to do
    - searchBy: the actual
*/
    
public func get(action : String, searchBy dict: [String:Any]? = nil) -> Just.HTTPResult {
    return Just.get(url, params: ["action": action] + dict)
}

// This is to use closers to load something in the background
public func get(action : String, searchBy dict: [String:Any]? = nil, completion: @escaping (Just.HTTPResult) -> Void) {
    Just.get(url, params: ["action": action] + dict) { r in
        completion(r)
    }
}

/*
 HTTP POST request to server side API.
 
 - Parameters:
    - action:
    - json: actual json object
    - postTo:
*/
public func post(action: String, json: [String: Any], with params: [String: Any]? = nil) -> Just.HTTPResult {
    print(["action": action] + params)
    return Just.post(url, params: ["action": action] + params, json: json)
}

// Completion is used for closures so that you can load something asynchronously and let the user do stuff
public func post(action : String, json: [String: Any], with params: [String:Any]? = nil, completion: @escaping (Just.HTTPResult) -> Void) {
    
    Just.post(url, params: ["action": action] + params, json: json) { r in
        completion(r)
    }
}
