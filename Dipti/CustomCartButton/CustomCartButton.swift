//
//  CustomCartButton.swift
//  FoodCenter
//
//  Created by Hadi Sharghi on 4/5/1397 .
//  Copyright © 1397 SoftWorks. All rights reserved.
//

import UIKit

class CustomCartButton: UIView {

    var buttonView: UIView?
    
    func setup(view: CustomCartView, target: AnyObject?) {
        if let delegateTarget = target as? CartButtonDelegate {
            view.delegate = delegateTarget
        }
        buttonView = view
        self.addSubview(buttonView!)
    }
    
    
    var badgeValue: Int = 0 {
        didSet {
            if let view = self.buttonView as? CustomCartView {
                view.badgeValue = badgeValue
            }
        }
    }
    
    public func setBadgeValue(value: Int, pulse: Bool = true) {
        if pulse {
            if let view = self.buttonView as? CustomCartView {
                view.setBadgeValue(value: value, pulse: pulse)
            }
        }
    }
}
