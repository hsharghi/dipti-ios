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
    
    
    class func formatPrice(price: Int, withLocale locale: String? = nil, addPrefix prefix: String? = nil, addSuffix suffix: String? = nil) -> String {
        let numberFormatter = NumberFormatter()
        if locale != nil {
            numberFormatter.locale = Locale(identifier: locale!)
        }
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","

        var formattedPrice = numberFormatter.string(from: NSNumber(value: price))

        if prefix != nil {
            formattedPrice = prefix! + (formattedPrice ?? "")
        }
        if suffix != nil {
            formattedPrice = (formattedPrice ?? "") + suffix!
        }

        return formattedPrice ?? ""

    }


    
}
