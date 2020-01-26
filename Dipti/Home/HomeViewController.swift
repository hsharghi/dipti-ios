//
//  HomeViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/21/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [100, 200, 300, 400].forEach { (tag) in
            if let view = self.view.viewWithTag(tag) {
                view.roundConrners(masks: [
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner,
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner
                ], radius: 10)
                
            }
        }
        print("homevc loaded \(Date().description)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier?.contains("embedCollectionMen") ?? false {
            if let vc = segue.destination as? CollectionFullWidthWidget {
                vc.backgroundImage = UIImage(named: "collection-men")
            }
        }
        if segue.identifier?.contains("embedCollectionWomen") ?? false {
            if let vc = segue.destination as? CollectionFullWidthWidget {
                vc.backgroundImage = UIImage(named: "collection-women")
            }
        }
    }
}
