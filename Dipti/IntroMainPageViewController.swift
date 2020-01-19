//
//  IntroPageViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/16/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol IntroPageDelegate: class {
    func skipButtonTapped()
}

class IntroMainPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var subViewControllers = [UIViewController]()
    var scrollView: UIScrollView?
    var currentPageIndex = 0
    
    convenience init (transitionStyle: UIPageViewController.TransitionStyle = .scroll,
                      navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal,
                      options: [UIPageViewController.OptionsKey: Any]? = nil,
                      viewControllers: [IntroSimplePage]) {
        
        self.init(transitionStyle: transitionStyle, navigationOrientation: navigationOrientation, options: options)
        subViewControllers = viewControllers
    }
    weak var introDelegate: IntroPageDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        scrollView = self.view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
        scrollView?.delegate = self

        if let firstViewController = subViewControllers.first {
            setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        } else {
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }

    }


    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.firstIndex(of: viewController) ?? 0
        guard index > 0 else {
            return nil
        }
    

        return subViewControllers[index - 1]

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = subViewControllers.firstIndex(of: viewController) ?? 0
        guard index < subViewControllers.count - 1 else {
            return nil
        }

        return subViewControllers[index + 1]
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if (!completed)
        {
            return
        }
        
        if let vc = self.viewControllers?.first, let index = subViewControllers.firstIndex(of: vc) {
            currentPageIndex = index
            if currentPageIndex == subViewControllers.count - 1 {
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
                button.center = CGPoint(x: self.view.frame.width - 50, y: self.view.frame.height - 100)
                button.tag = 1000
                button.setTitle("OK", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.layer.borderColor = UIColor.white.cgColor
                button.layer.borderWidth = 1
                button.addTarget(self, action: #selector(finishButtonTapped(sender:)), for: .touchUpInside)
                self.view.addSubview(button)
            } else {
                if let button = self.view.subviews.filter({$0.tag == 1000}).first {
                    button.removeFromSuperview()
                }
            }
        }
    }

    @objc func finishButtonTapped(sender: Any?) {
        print("button tapped")
        introDelegate?.skipButtonTapped()
    }
    
}


extension IntroMainPageViewController: UIScrollViewDelegate {

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        print("offset x: \(scrollView.contentOffset.x)")
//
//        let frame = scrollView.frame
//        let toVCIndex = scrollView.contentOffset.x > frame.width ? currentPageIndex + 1 : currentPageIndex - 1
//        guard toVCIndex > 0 && toVCIndex < (subViewControllers.count - 1) else {
//            return
//        }
//        let toVC = subViewControllers[currentPageIndex]
//        let alpha: CGFloat = abs(scrollView.contentOffset.x - frame.width) / scrollView.contentOffset.x
////        print(alpha)
////        print(currentPageIndex)
//
//        toVC.view.alpha = alpha == 0.5 ? 1 : 1 - alpha
//
//    }
    
    
    
    
}
