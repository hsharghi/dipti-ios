//
//  SceneDelegate.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/16/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if let scene = (scene as? UIWindowScene) {
            
            let window = UIWindow(windowScene: scene)
            
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
        else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

extension SceneDelegate: IntroPageDelegate {
    
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
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!
    }
}
