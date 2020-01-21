//
//  MainViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/20/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import ESTabBarController

class MainViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var currentViewController: UIViewController?
    var viewControllers: [UIViewController] {
        makeViewControllers()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    private func makeViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)
        viewControllers.append(UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()!)

        return viewControllers
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedCustomTabbar" {
            if let vc = segue.destination as? CustomTabbar {
                vc.delegate = self
            }
        }
    }
    
    
}


extension MainViewController: CustomTabbarDelegate {
    func didSelectTabItem(index: Int) {
        if let viewController = self.viewControllers[optional: index] {
            ViewEmbedder.embed(parent: self,
                               container: containerView,
                               child: viewController,
                               previous: currentViewController)
        }
    }
}
