//
//  ScrollableViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 2/2/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol ScrollableViewControllerDelegate: UIViewController {
    func scrollViewDidSet(scrollView: UIScrollView)
}

extension ScrollableViewControllerDelegate {
    func scrollViewDidSet(scrollView: UIScrollView) { }
}

class ScrollableViewController: UIViewController, UIScrollViewDelegate {
    
    weak var scrollableDelegate: ScrollableViewControllerDelegate?
    
    var scrollView: UIScrollView? {
        didSet {
            if let scrollView = scrollView {
                scrollView.delegate = self
                scrollableDelegate?.scrollViewDidSet(scrollView: scrollView)
            }
        }
    }


}
