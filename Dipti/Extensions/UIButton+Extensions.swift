//
//  UIButton+Extensions.swift
//  RAF
//
//  Created by Hadi Sharghi on 3/31/1397 .
//  Copyright © 1397 Hadi Sharghi. All rights reserved.
//

import UIKit

extension UIButton {
    func flip(withImage: Bool = false) {
        self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        if withImage {
            self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
    
    @objc override func rounded(color: UIColor? = nil, width: CGFloat = 1, paddingX: CGFloat = 0, paddingY: CGFloat = 0) {
        self.contentEdgeInsets = UIEdgeInsets(top: paddingY, left: paddingX, bottom: paddingY, right: paddingX)
//        self.frame.size.width += paddingX
//        self.frame.size.height += paddingY
        self.layer.cornerRadius = self.bounds.height / 2
        var borderColor = color
        if color == nil {
            borderColor = self.titleLabel?.textColor
        }
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = width
        self.clipsToBounds = true
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80 // adjust your size here
        return sizeThatFits
    }
}
