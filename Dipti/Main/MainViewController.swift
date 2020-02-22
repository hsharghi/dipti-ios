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
    @IBOutlet weak var searchViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: PaddedTextField!
    
    var currentViewController: UIViewController?
    var viewControllers = [UIViewController]()
    var currentNavigationController: UINavigationController? {
        return (currentViewController as? UINavigationController) ??
            currentViewController?.navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppData.main = self
        
        searchTextField.setInset(insets: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10))
        
        safeFixView.backgroundColor = AppData.color.yellow
        setupSideMenu()
        toggleBackButton()
    }
        
    func hideSearch() {
        searchViewTopConstraint.constant = -30
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showSearch() {
        searchViewTopConstraint.constant = 44
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollSearchArea(offset: CGFloat) {
        
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
            backButton.isHidden = !(currentNavigationController?.viewControllers.count ?? 1 > 1)
    }
    
    public func embedViewController(viewController: UIViewController, _ completion: ((UIViewController) -> Void)? = nil) {
        ViewEmbedder.embed(parent: self, container: containerView, child: viewController, previous: currentViewController) { (vc) in
            self.currentViewController = vc
            completion?(vc)
        }
    }
    
    public func pushViewController(viewController: UIViewController, _ completion: ((UIViewController) -> Void)? = nil) {
        currentNavigationController?.pushViewController(viewController, animated: true)
        completion?(viewController)
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
                                if let vc = vc as? ScrollableNavigationController {
                                    self.currentViewController = vc
                                    vc.scrollableDelegate = self
                                }
                                
            }
        }
    }
}

extension MainViewController: ScrollableNavigationControllerDelegate {
    
    func childScrollViewDidScroll(_ scrollView: UIScrollView, direction: ScrollDirection ) {
        if direction == .down && scrollView.contentOffset.y > 0 {
            hideSearch()
        }
        if direction == .up && scrollView.contentOffset.y < scrollView.contentSize.height - scrollView.frame.height {
            showSearch()
        }
    }
    
    func scrollViewDidSet(scrollView: UIScrollView) {
        print(scrollView)
    }
}


