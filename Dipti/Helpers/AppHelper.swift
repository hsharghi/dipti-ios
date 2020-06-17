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
    
    

    class func formatNumber(_ number: Int, withLocale locale: String? = nil, addPrefix prefix: String? = nil, addSuffix suffix: String? = nil) -> String {
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

    

    class func formatDate(_ date: Date, format: String, timezone: TimeZone? = TimeZone(identifier: "IRST"), withLocale locale: String? = "fa_IR", addPrefix prefix: String? = nil, addSuffix suffix: String? = nil) -> String {

        let dateFormatter = DateFormatter(format: format, timeZone: timezone ?? TimeZone.current, locale: locale ?? Locale.current.identifier)
        
        var formattedDate = dateFormatter.string(from: date)
        
        if prefix != nil {
            formattedDate = prefix! + formattedDate
        }
        if suffix != nil {
            formattedDate = formattedDate + suffix!
        }

        return formattedDate

    }

    
    static func addOrder(order: Order) {
        var orders = AppData.orders
        orders.append(order)
        AppData.orders = orders
    }
    
    static func updateOrder(order: Order) {
        var orders = AppData.orders
        if let theOrder = orders.filter({$0.id == order.id}).first {
            orders.replace(object: theOrder, with: order)
        }
        AppData.orders = orders
    }

    
    static func showAlert(_ title: String, message: String?, dismissButtonTitle: String = "OK", actions: [UIAlertAction]? = nil, completion: (() -> Void)? = nil) -> Void {
        AppData.appDelegate.showAlert(title, message: message ?? "", dismissButtonTitle: dismissButtonTitle, actions: actions, completion: completion)
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
    
    class func showOrders(in viewController: UIViewController, completion: (() -> Void)? = nil) {
        if let vc = UIStoryboard(name: "Order", bundle: nil).instantiateInitialViewController() {
            viewController.present(vc, animated: true) {
                if let completion = completion {
                    completion()
                }
            }
        }
    }

    class func showAddresses(in viewController: UIViewController, completion: (() -> Void)? = nil) {
        if let vc = UIStoryboard(name: "Address", bundle: nil).instantiateInitialViewController() {
            viewController.present(vc, animated: true) {
                if let completion = completion {
                    completion()
                }
            }
        }
    }

    class func logout() {
        AppData.loginToken = nil
        AppData.customer = nil
    }
}
