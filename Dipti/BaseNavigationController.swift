//
//  BaseNavigationController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/19/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = .black
        appearance.barTintColor = .black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        self.title = "sdkfjslkdfj"
//        self.navigationItem.titleView = UIImageView(image: UIImage(named: "dipti-full-icon-white"))
//
        let image: UIImage = UIImage(named: "menu-currency")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    
}
