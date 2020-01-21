//
//  AppDelegate.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/16/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let window = window {
            
            
            let showIntro = UserDefaults.standard.value(forKey: "showIntro") as? Bool
            var viewController: UIViewController
            
            if showIntro ?? true {
                viewController = makeIntroVC()
            } else {
                viewController = makeMainViewController()
            }
            
            window.rootViewController = viewController
            
            self.window = window
            self.window?.makeKeyAndVisible()
            
            
        }
        
        
        return true
    }


}


extension AppDelegate: IntroPageDelegate {
    
    func skipButtonTapped() {
        
        UserDefaults.standard.set(false, forKey: "showIntro")
        
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() {
            
            if let snapshot = (UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.snapshotView(afterScreenUpdates: true)) {
                vc.view.addSubview(snapshot)
                window?.rootViewController = vc
                UIView.transition(with: snapshot,
                                  duration: 1,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    snapshot.layer.opacity = 0
                },
                                  completion: { status in
                                    snapshot.removeFromSuperview()
                })
                
            }
            
            //
            //            UIView.transition(with: window!, duration: duration, options: options, animations: {}, completion:
            //            { completed in
            //                // maybe do something on completion here
            //            })
            
        }
        
    }
    
    
    
    func makeIntroVC() -> UIViewController {
        
        
        let viewController = IntroMainPageViewController(viewControllers: [
            IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "فروش آنلاین کارهای تکدوز و محدود طراح ها و هنرمندهای ایرانی"),
            IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "صفحه دوم سلام. خوش آمدید"),
            //                IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "یک صفحه دیگه نمیدونم دیگه صفحه چندمه"),
            //                IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "بازم صفحه بعدی. دیگه به نظر همه چی درسته"),
            //                IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "صفحه آخر رسیدیم"),
        ])
        
        viewController.introDelegate = self
        
        return viewController
    }
    
    func makeMainViewController() -> UIViewController {
        if let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? MainViewController {
            
            mainVC.viewControllers = MainViewControlelrsFactory.makeViewControlelrs()
            return mainVC
            
        }
        return UIViewController()
    }
}
