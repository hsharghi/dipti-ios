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
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print(viewController)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollableDelegate?.childScrollViewDidScroll(scrollView, direction: scrollView.contentOffset.y > lastContentOffset ? .down : .up)
        lastContentOffset = scrollView.contentOffset.y
    }

}

enum ScrollDirection {
    case up
    case down
}


class PopDetailImageAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    public let CustomAnimatorTag = 99
    
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect
    var image : UIImage
    
    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect, image : UIImage) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.image = image
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        guard let artwork = detailView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
        artwork.image = image
        artwork.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : artwork.frame)
        transitionImageView.image = image
        
        container.addSubview(transitionImageView)
        
        toView.frame = isPresenting ?  CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? artwork.frame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            artwork.alpha = 1
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}




class CustomInteractor : UIPercentDrivenInteractiveTransition {
    
    var navigationController : UINavigationController
    var shouldCompleteTransition = false
    var transitionInProgress = false
    
    init?(attachTo viewController : UIViewController) {
        if let nav = viewController.navigationController {
            self.navigationController = nav
            super.init()
            setupBackGesture(view: viewController.view)
        } else {
            return nil
        }
    }
    
    private func setupBackGesture(view : UIView) {
        let swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
        swipeBackGesture.edges = .left
        view.addGestureRecognizer(swipeBackGesture)
    }
    
    @objc private func handleBackGesture(_ gesture : UIScreenEdgePanGestureRecognizer) {
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        let progress = viewTranslation.x / self.navigationController.view.frame.width
        
        switch gesture.state {
        case .began:
            transitionInProgress = true
            navigationController.popViewController(animated: true)
            break
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            break
        case .cancelled:
            transitionInProgress = false
            cancel()
            break
        case .ended:
            transitionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
            break
        default:
            return
        }
    }
    
}

extension Product {
    func uiImage() -> UIImage? {
        return UIImage(named: self.image)
    }
}
