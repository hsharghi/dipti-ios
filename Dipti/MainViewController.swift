//
//  MainViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/20/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import ESTabBarController

class MainViewController: UIViewController {
    
//
//    init(viewControllers: [UIViewController]) {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setupViewControllers()

        
    }
    
    func setupViewControllers() {
        
//
//        if let tabBar = self.tabBar as? ESTabBar {
//            tabBar.itemCustomPositioning = .fillIncludeSeparator
//        }

        let v1 = ViewController()
        let v2 = ViewController()
        let v3 = ViewController()
        let v4 = ViewController()
        let v5 = ViewController()

        v1.tabBarItem = ESTabBarItem.init(HomeTabbarContentView(), title: "صفحه اصلی", image: UIImage(named: "tab-home"), selectedImage: UIImage(named: "tab-home"))
        v2.tabBarItem = ESTabBarItem.init(HomeTabbarContentView(), title: "مجموعه‌ها", image: UIImage(named: "tab-collections"), selectedImage: UIImage(named: "tab-collections"))
        v3.tabBarItem = ESTabBarItem.init(HomeTabbarContentView(), title: "طراحان", image: UIImage(named: "tab-designers"), selectedImage: UIImage(named: "tab-designers"))
//        v4.tabBarItem = ESTabBarItem.init(HomeTabbarContentView(), title: "دسته‌بندی‌ها", image: UIImage(named: "tab-category"), selectedImage: UIImage(named: "tab-category"))
        v5.tabBarItem = ESTabBarItem.init(HomeTabbarContentView(), title: "پروفایل", image: UIImage(named: "tab-new"), selectedImage: UIImage(named: "tab-new"))

//        self.viewControllers = [v1, v2, v3, v5]

    }
    
}


class HomeTabbarContentView: ESTabBarItemContentView {

    
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         textColor = AppData.color.darkBlue
         highlightTextColor = AppData.color.darkBlue
         iconColor = AppData.color.darkBlue
         highlightIconColor = AppData.color.darkBlue
         backdropColor = AppData.color.gray
         highlightBackdropColor = AppData.color.yellow
     }
     
     public required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
