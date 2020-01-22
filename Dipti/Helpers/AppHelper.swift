//
//  AppHelper.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/22/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class AppHelper {
    
    class func addGradientLayer(to view: UIView, startColor: UIColor = .clear, endColor: UIColor = .clear, startPoint: CGPoint, endPoint: CGPoint) {
        view.createGradientLayer(color1: startColor,
                color2: endColor,
                startPoint: startPoint,
                endPoint: endPoint)
    }

    
}
