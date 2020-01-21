//
//  MainViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/20/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var safeFixView: UIView!
    
    var currentViewController: UIViewController?
    var viewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
   
        safeFixView.backgroundColor = AppData.color.yellow
        
        setupSideMenu()
    }

    
    private func setupSideMenu() {
        
        SideMenuFactory.shared.setRightMenu()
        
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        SideMenuFactory.shared.showRightSideMenu(in: self)
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
