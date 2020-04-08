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

