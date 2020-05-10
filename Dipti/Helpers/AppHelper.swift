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
    
    

    class func formatNumber(number: Int, withLocale locale: String? = nil, addPrefix prefix: String? = nil, addSuffix suffix: String? = nil) -> String {
        let numberFormatter = NumberFormatter()
        if locale != nil {
            numberFormatter.locale = Locale(identifier: locale!)
        }
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","

        var formattedPrice = numberFormatter.string(from: NSNumber(value: number))

        if prefix != nil {
            formattedPrice = prefix! + (formattedPrice ?? "")
        }
        if suffix != nil {
            formattedPrice = (formattedPrice ?? "") + suffix!
        }

        return formattedPrice ?? ""

    }

    
    static func showAlert(_ title: String, message: String?, actions: [UIAlertAction]? = nil, completion: (() -> Void)? = nil) -> Void {
        AppData.appDelegate.showAlert(title, message: message ?? "", actions: actions, completion: completion)
    }

    static func showShareControl(items: [Any], in viewController: UIViewController, completion: (() -> Void)? = nil) -> Void {
        AppData.appDelegate.showShareControl(items: items, in: viewController, completion: completion)
    }

    
    class func showLogin(in viewController: UIViewController, completion: (() -> Void)? = nil) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() as! AuthNavigationController
        viewController.present(vc, animated: true) {
            if let completion = completion {
                completion()
            }
        }
    }

}
