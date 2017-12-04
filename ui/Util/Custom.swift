//
//  Custom.swift
//  UI
//
//  Created by Braden McKallagat on 12/2/17.
//  Copyright © 2017 Kevin S Delay. All rights reserved.
//

import Foundation

/* Swift doesn't automatically let you add dictionaries, this is just a fun helper method to do so
    Found here: https://stackoverflow.com/questions/24051904/how-do-you-add-a-dictionary-of-items-into-another-dictionary
 */
public func + <K,V>(left: Dictionary<K,V>?, right: Dictionary<K,V>?) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    
    if (right != nil && left != nil) {
        for ((key: a, value: c), (key: b, value: d)) in zip(left!, right!) {
            map[a] = c
            map[b] = d
        }
    } else if (right == nil && left != nil) {
        map = left!
    } else if (right != nil && left == nil) {
        map = right!
    }
    
    return map
}
