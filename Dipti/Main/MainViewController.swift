//
//  MainViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/20/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var containerView: RoundShadowView!
    @IBOutlet weak var safeFixView: UIView!
    @IBOutlet weak var backButton: UIView!
    @IBOutlet weak var searchViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: PaddedTextField!
    @IBOutlet weak var cartButton: CustomCartButton!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchContainerHeightConstraint: NSLayoutConstraint!
    
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
        
        searchTextField.setInset(insets: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10))
        setupCartButton()

        safeFixView.backgroundColor = AppData.color.yellow
        setupSideMenu()
        toggleBackButton()

        containerView.roundConrners(masks: .allCorners, radius: 20)
        containerView.layer.masksToBounds = true
        
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
            
            self.searchContainerHeightConstraint.constant = self.view.bounds.height - 180 - keyboardFrame.height
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }

//            var frame = containerView.frame
//            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height - keyboardFrame.height)
//            containerView.frame = frame
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardFrame = self.view.convert(keyboardSize, from: nil)
            
            
            self.searchContainerHeightConstraint.constant = self.view.bounds.height - 266
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }

//
//        var frame = containerView.frame
//        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height + keyboardFrame.height)
//        containerView.frame = frame
//
//        UIView.animate(withDuration: 0.3) {
//            self.containerView.setNeedsLayout()
//        }
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

        ViewEmbedder.embed(storyboard: UIStoryboard(name: "SearchResult", bundle: nil),
                           withIdentifier: String(describing: SearchResultViewController.self),
                           parent: self,
                           container: searchContainer,
                           removePrevious: false) { (vc) in
                            if let vc = vc as? SearchResultViewController {
                                self.searchResultViewController = vc
                                vc.delegate = self
                                vc.setSearchTerm(term: searchTerm)
                            }
                            self.searchContainerHeightConstraint.constant = self.view.bounds.height - 266
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
        print("cart button tapped")
    }
    
    
}

extension MainViewController: CartDelegate {
    func cartItemsChanged(count: Int) {
        cartButton.badgeValue = count
    }
}


extension MainViewController: SearchResultViewDelegate {
    func closeButtonTapped() {
        if let vc = searchResultViewController {
            ViewEmbedder.removeFromParent(vc: vc)
            searchResultViewController = nil
        }
    }
    
    func hideKeyboard() {
        searchTextField.endEditing(true)
    }
}



class RoundShadowView: UIView {
  
    let containerView = UIView()
    let cornerRadius: CGFloat = 20
  
    override init(frame: CGRect) {
        super.init(frame: frame)

        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
               super.init(coder: aDecoder)
        layoutView()

    }

    func layoutView() {
      
      // set the shadow of the view's layer
      layer.backgroundColor = UIColor.clear.cgColor
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 1.0)
      layer.shadowOpacity = 0.4
      layer.shadowRadius = 6.0
        
      // set the cornerRadius of the containerView's layer
      containerView.layer.cornerRadius = cornerRadius
      containerView.layer.masksToBounds = true
      
      addSubview(containerView)
      
      //
      // add additional views to the containerView here
      //
      
      // add constraints
      containerView.translatesAutoresizingMaskIntoConstraints = false
      
      // pin the containerView to the edges to the view
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
