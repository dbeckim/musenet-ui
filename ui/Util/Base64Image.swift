//
//  Base64Image.swift
//  UI
//
//  Created by Braden McKallagat on 12/2/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import Foundation
import UIKit

/*
 Convert UIImage to Base64 Encoding
 Adapted from https://stackoverflow.com/questions/11251340/convert-between-uiimage-and-base64-string
 
 - Parameters:
    - image: UIImage to encode to Base64 string
 - Returns: A Base64 encoded string
 */
public func EncodeImage(image: UIImage) -> String {
    let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
    return imageData.base64EncodedString(options: .lineLength64Characters)
}

/*
 Convert Base64 string to UIImage
 Adapted from https://stackoverflow.com/questions/11251340/convert-between-uiimage-and-base64-string
 
 - Parameters: 
    - fromBase64: Base64 string to decode to UIImage
 - Returns: a UIImage
*/
public func DecodeImage(fromBase64: String) -> UIImage? {
    let dataDecoded: NSData = NSData(base64Encoded: fromBase64, options: .ignoreUnknownCharacters)!
    return UIImage(data: dataDecoded as Data)
}
