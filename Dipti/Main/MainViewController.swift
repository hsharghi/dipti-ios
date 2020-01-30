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
    @IBOutlet weak var backButton: UIView!
    
    var currentViewController: UIViewController?
    var viewControllers = [UIViewController]()
    var currentNavigationController: UINavigationController? {
        return (currentViewController as? UINavigationController) ??
            currentViewController?.navigationController 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppData.appDelegate.mainViewController = self
        
        safeFixView.backgroundColor = AppData.color.yellow
        
        setupSideMenu()
    }
    
    
    private func setupSideMenu() {
        
        SideMenuFactory.shared.setRightMenu()
        
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        SideMenuFactory.shared.showRightSideMenu(in: self)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        currentNavigationController?.popViewController(animated: true)
        toggleBackButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedCustomTabbar" {
            if let vc = segue.destination as? CustomTabbar {
                vc.delegate = self
            }
        }
    }
    
    private func toggleBackButton() {
            backButton.isHidden = !(currentNavigationController?.viewControllers.count ?? 0 > 1)
    }
    
    public func embedViewController(viewController: UIViewController, _ completion: ((UIViewController) -> Void)? = nil) {
        ViewEmbedder.embed(parent: self, container: containerView, child: viewController, previous: currentViewController) { (vc) in
            self.currentViewController = vc
            completion?(vc)
        }
    }
    
    public func pushViewController(viewController: UIViewController, _ completion: ((UIViewController) -> Void)? = nil) {
        currentNavigationController?.pushViewController(viewController, animated: true)
        toggleBackButton()
    }
    
}


extension MainViewController: CustomTabbarDelegate {
    func didSelectTabItem(index: Int) {
        if let viewController = self.viewControllers[optional: index] {
            ViewEmbedder.embed(parent: self,
                               container: containerView,
                               child: viewController,
                               previous: currentViewController) { vc in
                                self.currentViewController = vc
            }
        }
    }
}
