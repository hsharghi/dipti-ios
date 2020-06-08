//
//  String+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 2/27/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

extension String {
    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }

    func toFa() -> String {
        let fa = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"]
        let en = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        var modifiedString = self
        self.forEach { character in
            if en.contains(String(character)) {
                if let index = en.firstIndex(of: String(character)) {
                    modifiedString = modifiedString.replacingOccurrences(of: String(character), with: fa[index])
                }
            }
        }
        modifiedString = modifiedString.replacingOccurrences(of: ".", with: "٫")
        return modifiedString
    }

    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()
    }

    func toEn() -> String {
        let fa = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"]
        let en = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        var modifiedString = self
        self.forEach { character in
            if fa.contains(String(character)) {
                if let index = fa.firstIndex(of: String(character)) {
                    modifiedString = modifiedString.replacingOccurrences(of: String(character), with: en[index])
                }
            }
        }
        modifiedString = modifiedString.replacingOccurrences(of: "٫", with: ".")
        return modifiedString
    }

    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex

        while searchStartIndex < self.endIndex,
              let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
              !range.isEmpty {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }

    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else {
            return self
        }
        return String(self.dropFirst(prefix.count))
    }
    
    var nsRange: NSRange {
        return NSRange(self.startIndex..., in: self)
    }
 
    var isNumeric : Bool {
        return Double(self) != nil
    }
}
