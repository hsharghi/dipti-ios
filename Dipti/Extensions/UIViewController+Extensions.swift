//
//  UIViewController+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/10/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func flashLoading(for duration: TimeInterval, _ completion: @escaping () -> Void) {
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.hideLoading()
            completion()
        }
    }
    
    func showLoading(style: UIActivityIndicatorView.Style = .whiteLarge) {
        hideLoading()
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        containerView.backgroundColor = .black
        containerView.alpha = 0
        containerView.tag = 3333333
        containerView.roundConrners(masks: .allCorners, radius: 20)
        let ai = UIActivityIndicatorView(style: style)
        ai.center = containerView.center
        containerView.addSubview(ai)
        containerView.center = self.view.center
        self.view.addSubview(containerView)
        ai.startAnimating()
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.5
        }
    }
    
    func hideLoading() {
        self.view.subviews.forEach { (view) in
            if view.tag == 3333333 {
                UIView.animate(withDuration: 0.25, animations: {
                    view.alpha = 0
                }) { (completed) in
                    if completed {
                        view.removeFromSuperview()
                    }
                }
            }
        }
    }
}

