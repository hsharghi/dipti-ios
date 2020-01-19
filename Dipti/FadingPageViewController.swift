////
////  FadingPageViewController.swift
////  Dipti
////
////  Created by Hadi Sharghi on 1/16/20.
////  Copyright © 2020 Hadi Sharghi. All rights reserved.
////
//
//import UIKit
//import Pageboy
//
//class FadingPageViewController: PageboyViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {
//    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: PageboyViewController.PageIndex, direction: PageboyViewController.NavigationDirection, animated: Bool) {
//        <#code#>
//    }
//    
//    
//    var subViewControllers = [UIViewController]()
//    
//    convenience init (viewControllers: [IntroSimplePage]) {
//        subViewControllers = viewControllers
//    }
//    
//    weak var introDelegate: IntroPageDelegate?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        dataSource = self
//        delegate = self
//        
//        
//
//        if let firstViewController = subViewControllers.first {
//            setViewControllers([firstViewController],
//                           direction: .forward,
//                           animated: true,
//                           completion: nil)
//        } else {
//            let vc = UIViewController()
//            vc.view.backgroundColor = .red
//            setViewControllers([vc], direction: .forward, animated: true, completion: nil)
//        }
//
//    }
//
//    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
//        return viewControllers.count
//    }
//
//    func viewController(for pageboyViewController: PageboyViewController,
//                        at index: PageboyViewController.PageIndex) -> UIViewController? {
//        return viewControllers[index]
//    }
//
//    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
//        return nil
//    }
//
////
////    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
////    {
////        if (!completed)
////        {
////            return
////        }
////        let index = pageViewController.viewControllers!.first!.view.tag //Page Index
////        print(index)
////        introDelegate?.pageChanged(to: index)
////
////    }
//
//    
//}
//
//
