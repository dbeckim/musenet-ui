//: Playground - noun: a place where people can play

import UIKit

let dict: [String: Any] = [
    "email": "something",
    "name" : "persons name",
    "password" : "1234567",
    "role": "producer",
    "location": "512.168.788",
    "bio": "I like music",
];

let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)

let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])

if let dictFromJSON = decoded as? [String:String] {
    for (key, value) in dictFromJSON {
        let str = String(format: "%@: %@", key, value)
        print(str)
    }
}
