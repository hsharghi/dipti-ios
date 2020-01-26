//
//  Date+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

extension Date {
    static func log(_ message: String = "") {
        let df = DateFormatter()
        df.dateFormat = "H:m:ss.SSSS"
        print("\(message) \(df.string(from: Date()))")

    }
}
