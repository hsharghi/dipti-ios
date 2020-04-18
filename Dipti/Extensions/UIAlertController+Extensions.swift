//
//  UIAlertController+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/8/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

extension UIAlertController {
     
    private static var globalPresentationWindow: UIWindow?
     
    func presentGlobally(animated: Bool, completion: (() -> Void)?) {
        UIAlertController.globalPresentationWindow = UIWindow(frame: UIScreen.main.bounds)
        UIAlertController.globalPresentationWindow?.rootViewController = UIViewController()
        UIAlertController.globalPresentationWindow?.windowLevel = UIWindow.Level.alert + 1
        UIAlertController.globalPresentationWindow?.backgroundColor = .clear
        UIAlertController.globalPresentationWindow?.makeKeyAndVisible()
        UIAlertController.globalPresentationWindow?.rootViewController?.present(self, animated: animated, completion: completion)
    }
     
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIAlertController.globalPresentationWindow?.isHidden = true
        UIAlertController.globalPresentationWindow = nil
    }
    

        //Set background color of UIAlertController
          func setBackgroudColor(color: UIColor) {
            if let bgView = self.view.subviews.first,
              let groupView = bgView.subviews.first,
              let contentView = groupView.subviews.first {
              contentView.backgroundColor = color
            }
          }

          //Set title font and title color
        func setTitle(font: UIFont? = nil,
                      color: UIColor? = nil) {
            guard let title = self.title else { return }
            let attributeString = NSMutableAttributedString(string: title)//1
            if let titleFont = font {
              attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                range: title.nsRange)
            }
            if let titleColor = color {
              attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                range: title.nsRange)
            }
            self.setValue(attributeString, forKey: "attributedTitle")//4
          }

          //Set message font and message color
          func setMessage(font: UIFont? = nil,
                          color: UIColor? = nil) {
            guard let title = self.message else {
              return
            }
            let attributedString = NSMutableAttributedString(string: title)
            if let titleFont = font {
              attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: title.nsRange)
            }
            if let titleColor = color {
              attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: title.nsRange)
            }
            self.setValue(attributedString, forKey: "attributedMessage")
          }

          //Set tint color of UIAlertController
          func setTint(color: UIColor) {
            self.view.tintColor = color
          }

     
}


extension UIActivityViewController {
     
    private static var globalPresentationWindow: UIWindow?
     
    func presentGlobally(animated: Bool, completion: (() -> Void)?) {
        UIActivityViewController.globalPresentationWindow = UIWindow(frame: UIScreen.main.bounds)
        UIActivityViewController.globalPresentationWindow?.rootViewController = UIViewController()
        UIActivityViewController.globalPresentationWindow?.windowLevel = UIWindow.Level.alert + 1
        UIActivityViewController.globalPresentationWindow?.backgroundColor = .clear
        UIActivityViewController.globalPresentationWindow?.makeKeyAndVisible()
        UIActivityViewController.globalPresentationWindow?.rootViewController?.present(self, animated: animated, completion: completion)
    }
     
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIActivityViewController.globalPresentationWindow?.isHidden = true
        UIActivityViewController.globalPresentationWindow = nil
    }
}

