//
//  UINavigationController+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/10/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

extension UINavigationController {
    func transparent(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.isTranslucent = true
        }
    }
    
    func opaque(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationBar.shadowImage = nil
        }
    }
}

