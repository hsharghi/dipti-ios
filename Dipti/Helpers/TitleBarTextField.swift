//
//  TitleTextFiled.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/31/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TitleBarTextField: SkyFloatingLabelTextField {
    
    // MARK: - Initializers

    /**
    Initializes the control
    - parameter frame the frame of the control
    */
    override public init(frame: CGRect) {
        rtl = true
        super.init(frame: frame)
    }

    /**
     Intialzies the control by deserializing it
     - parameter aDecoder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        rtl = true
        super.init(coder: aDecoder)
    }
    
        
    /// A UIColor value that determines the color of the bottom line when in the normal state
    @IBInspectable dynamic open var rtl: Bool {
        didSet {
            isLTRLanguage = !rtl
        }
    }

    
    private let leftPadding: CGFloat = 6
    private let rightPadding: CGFloat = 16

    override var errorMessage: String? {
        didSet {
            super.errorMessage = errorMessage
            if let errorMessage = errorMessage, errorMessage.count > 0 {
                self.titleFont =  UIFont(name: "IRANSansWeb", size: 14)!
            } else {
                self.titleFont =  UIFont(name: "IRANSansWeb", size: 6)!
                self.titleColor = .clear
            }
        }
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width - rightPadding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )

        return rect

    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width - rightPadding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )

        return rect

    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width - rightPadding,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )

        return rect

    }

    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {

        if editing {
            return CGRect(x: leftPadding, y: 5, width: bounds.size.width, height: titleHeight())
        }

        return CGRect(x: leftPadding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }


    
}
