//
//  UIPicker+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/6/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


extension UIPickerView {
    
    func horizontal() {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double(-90).toRad()))
    }
    
    
}
