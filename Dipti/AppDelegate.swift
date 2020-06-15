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
    var alertWindow: UIWindow?
    var loginToken: String?
    var searchFilter = SearchFilter()
    var mockFactory = ProductMockFactory(count: 20)
    
    var mainViewController: MainViewController? {
        didSet {
            if let vc = mainViewController {
                cart.delegate = vc
            }
        }
    }
    var cart = Cart()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let showIntro = UserDefaults.standard.value(forKey: "showIntro") as? Bool
        var viewController: UIViewController
        
        if showIntro ?? true {
            viewController = makeIntroVC()
        } else {
//            viewController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()!
            viewController = makeMainViewController()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(sideMenuItemTapped(notification:)),
                                               name: NSNotification.Name(rawValue: AppData.sideMenuSelectNotificationKey),
                                               object: nil)
        
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
        loginToken = AppData.loginToken
        
        return true
    }

    @objc private func sideMenuItemTapped(notification: Notification) {
        if let selector = notification.userInfo?["selector"] as? String {
            switch selector {
            case "login":
                showLogin()
            case "logout":
                logout()
            case "orders":
                showOrders()
            default:
                break
            }
        }
        print(notification.userInfo)
    }

    private func showOrders() {
        if let vc = window?.rootViewController {
            vc.dismiss(animated: true) {
                AppHelper.showOrders(in: vc) {
                        print("completed!")
                }
            }
        }
    }
    
    private func showLogin() {
        if let vc = window?.rootViewController {
            vc.dismiss(animated: true) {
                AppHelper.showLogin(in: vc) {
                        print("completed!")
                }
            }
        }
    }
    
    private func logout() {
        AppData.loginToken = nil
    }
    
    func showAlert(_ title: String, titleFont: UIFont? = nil, message: String, messageFont: UIFont? = nil, dismissButtonTitle: String = "OK", actions: [UIAlertAction]? = nil, completion: (() -> Void)? = nil) -> Void {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var alertTitleFont = UIFont(name: "IRANSansWeb-Bold", size: 20)
        var alertMessageFont = UIFont(name: "IRANSansWeb", size: 16)
        if let titleFont = titleFont {
            alertTitleFont = titleFont
        }
        alert.setTitle(font: alertTitleFont, color: nil)

        if let messageFont = messageFont {
            alertMessageFont = messageFont
        }
        alert.setMessage(font: alertMessageFont, color: nil)
//        // Change background color of UIAlertController
//        alertController.setBackgroudColor(color: UIColor.black)

        if let actions = actions {
            actions.forEach { (action) in
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: dismissButtonTitle, style: .default))
        }
        
        alert.presentGlobally(animated: true) {
            if let closure = completion {
                closure()
            }
        }

    }

    func showShareControl(items: [Any], in viewController: UIViewController, completion: (() -> Void)? = nil) -> Void {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
        }

        activityVC.presentGlobally(animated: true) {
            if let closure = completion {
                closure()
            }
        }
    }


}


extension AppDelegate: IntroPageDelegate {
    
    func skipButtonTapped() {
        
        UserDefaults.standard.set(false, forKey: "showIntro")
        
        if let vc = makeMainViewController() as? MainViewController {
            
            if let snapshot = (UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.snapshotView(afterScreenUpdates: true)) {
                vc.view.addSubview(snapshot)
                window?.rootViewController = vc
                UIView.transition(with: snapshot,
                                  duration: 0.25,
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
            IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "یک صفحه دیگه نمیدونم دیگه صفحه چندمه"),
            IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "بازم صفحه بعدی. دیگه به نظر همه چی درسته"),
            IntroPageFactory.createIntroPage(logoImage: UIImage(named: "dipti-logo-yellow"), textImage: UIImage(named: "dipti-text-yellow"), message: "صفحه آخر رسیدیم"),
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
