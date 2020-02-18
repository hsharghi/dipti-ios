//
//  ScrollableNavigationController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 2/18/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


protocol ScrollableNavigationControllerDelegate: UIViewController {
    func scrollViewDidSet(scrollView: UIScrollView)
    func childScrollViewDidScroll(_ scrollView: UIScrollView, direction: ScrollDirection)
}

extension ScrollableNavigationControllerDelegate {
    func scrollViewDidSet(scrollView: UIScrollView) { }
}

class ScrollableNavigationController: UINavigationController {
    
    weak var scrollableDelegate: ScrollableNavigationControllerDelegate?
    private var lastContentOffset: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        if let vc = viewControllers.first as? ScrollableViewController {
            delegate = self
            vc.scrollableDelegate = self
        }
    }
    
    
}

extension ScrollableNavigationController: ScrollableViewControllerDelegate {
    func scrollViewDidSet(scrollView: UIScrollView) {
        scrollView.delegate = self
        scrollableDelegate?.scrollViewDidSet(scrollView: scrollView)
    }
}

extension ScrollableNavigationController: UINavigationControllerDelegate, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollableDelegate?.childScrollViewDidScroll(scrollView, direction: scrollView.contentOffset.y > lastContentOffset ? .down : .up)
        lastContentOffset = scrollView.contentOffset.y
    }

}

enum ScrollDirection {
    case up
    case down
}
