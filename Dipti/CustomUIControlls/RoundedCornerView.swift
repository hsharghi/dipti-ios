//
//  RoundedCornerView.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/6/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

@IBDesignable class RoundedCornerView: UIView {
    
    
    /// A UIColor value that determines the color of the bottom line when in the normal state
    @IBInspectable dynamic open var cornerRadius: CGFloat = 0 {
        didSet {
            self.roundConrners(masks: .allCorners, radius: cornerRadius)
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
}
