//
//  MainViewControllersFactory.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/21/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class MainViewControlelrsFactory {
    
    class func makeViewControlelrs() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController()!)

        return viewControllers

    }
    
}
