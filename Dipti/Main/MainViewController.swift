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
    @IBOutlet weak var cartButton: CustomCartButton!
    //    @IBOutlet weak var searchContainer: UIView!
    //    @IBOutlet weak var searchContainerHeightConstraint: NSLayoutConstraint!
    
    var currentViewController: UIViewController?
    var viewControllers = [UIViewController]()
    var currentNavigationController: UINavigationController? {
        return (currentViewController as? UINavigationController) ??
            currentViewController?.navigationController
    }
    var searchResultViewController: SearchResultViewController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppData.main = self
        
        searchTextField.setInset(insets: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 50))
        setupCartButton()
        
        safeFixView.backgroundColor = AppData.color.yellow
        setupSideMenu()
        toggleBackButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func setupCartButton() {
        let cartView = CustomCartView.instanceFromNib(frame: cartButton.frame)
        cartButton.setup(view: cartView, target: self)
        cartButton.badgeValue = 0
    }
    
    
    
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardFrame = self.view.convert(keyboardSize, from: nil)
            
            if let searchView = searchResultViewController?.view.superview {
                let frame = searchView.frame
                let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: view.bounds.height - 180 - keyboardFrame.height)
                UIView.animate(withDuration: 0.25) {
                    searchView.frame = newFrame
                    searchView.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if let searchView = searchResultViewController?.view.superview {
                let frame = searchView.frame
                let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: view.bounds.height - 266)
                UIView.animate(withDuration: 0.25) {
                    searchView.frame = newFrame
                    searchView.layoutIfNeeded()
                }
            }
            
        }
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
    
    @IBAction func searchChanged(_ sender: Any) {
        if let textField = sender as? UITextField, let searchTerm = textField.text, searchTerm.count > 0 {
            
            if searchResultViewController == nil {
                showSearchResultVC(with: searchTerm)
                return
            }
            
            searchResultViewController?.setSearchTerm(term: searchTerm)
            
        }
        
    }
    
    private func showSearchResultVC(with searchTerm: String) {
        
        let view = RoundShadowView(frame: CGRect(x: searchTextField.frame.origin.x,
                                                 y: searchTextField.frame.origin.y + searchTextField.frame.height + 8,
                                                 width: searchTextField.frame.width,
                                                 height: self.view.bounds.height - 266))
        
        view.tag = 999
        
        self.view.addSubview(view)
        
        ViewEmbedder.embed(storyboard: UIStoryboard(name: "Search", bundle: nil),
                           withIdentifier: String(describing: SearchResultViewController.self),
                           parent: self,
                           container: view,
                           removePrevious: false) { (vc) in
                            if let vc = vc as? SearchResultViewController {
                                self.searchResultViewController = vc
                                vc.delegate = self
                                vc.setSearchTerm(term: searchTerm)
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
                               previous: currentViewController) { vc in
                                if let vc = vc as? ScrollableNavigationController {
                                    self.currentViewController = vc
                                    vc.scrollableDelegate = self
                                }
                                self.toggleBackButton()
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


extension MainViewController: CartButtonDelegate {
    func cartButtonTapped() {
        
        if let vc = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(identifier: String(describing: CartViewController.self)) as? CartViewController {
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
}

extension MainViewController: CartDelegate {
    func cartItemsChanged(count: Int) {
        cartButton.badgeValue = count
    }
}


extension MainViewController: SearchResultViewDelegate {
    func closeButtonTapped() {
        searchTextField.text = ""
        dismissSearchView()
    }
    
    func hideKeyboard() {
        searchTextField.endEditing(true)
    }
    
    func productTapped(product: Product) {
        if let vc = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(identifier: String(describing: ProductDetailViewController.self)) as? ProductDetailViewController {
            vc.product = product
            pushViewController(viewController: vc)
        }
    }
    
    func dismissSearchView() {
        let searchView = self.view.subviews.filter { $0.tag == 999 }.first
        searchView?.removeFromSuperview()
        searchResultViewController = nil
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchChanged(textField)
    }
}
