//
//  PaddedTextField.swift
//  Dipti
//
//  Created by Hadi Sharghi on 2/19/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class PaddedTextField : UITextField {
    private var insets = UIEdgeInsets.zero
    private var verticalPadding:CGFloat = 0
    private var horizontalPadding:CGFloat = 0

    func setInset(insets: UIEdgeInsets) {
        self.insets = insets
        self.setNeedsLayout()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + insets.left,
                      y: bounds.origin.y + insets.top,
                      width: bounds.size.width - (insets.left + insets.right),
                      height: bounds.size.height - (insets.top + insets.bottom));
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
