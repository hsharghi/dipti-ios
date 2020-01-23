//
//  UIImage+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/23/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


extension UIImage {
    var md5: String {
        guard let data = self.pngData() else {
            fatalError("Invalid image data")
        }
        return data.md5
    }
}

