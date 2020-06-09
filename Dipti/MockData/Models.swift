//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

class Models {
    class func generateID(length: Int = 10) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890-"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    class func generateID(length: Int = 10) -> Int {
        let letters = "1234567890"
        let stringId = String((0..<length).map{ _ in letters.randomElement()! })
        return Int(stringId)!
    }
    
}
