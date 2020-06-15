//
//  HomeViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/21/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class HomeViewController: ScrollableViewController {
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    override func viewDidLoad() {
        scrollView = scrollViewOutlet
        super.viewDidLoad()
        [100, 200, 300, 400].forEach { (tag) in
            if let view = self.view.viewWithTag(tag) {
                view.roundConrners(masks: .allCorners, radius: 10)
                
            }
        }
        print("homevc loaded \(Date().description)")
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case AppData.segueMenCollection:
            if let vc = segue.destination as? CollectionFullWidthWidget {
                vc.delegate = self
                vc.identifier = AppData.menCollectionWidgetIdentifier
                vc.backgroundImage = UIImage(named: "collection-men")
            }
        case AppData.segueWomenCollection:
            if let vc = segue.destination as? CollectionFullWidthWidget {
                vc.delegate = self
                vc.identifier = AppData.womenCollectionWidgetIdentifier
                vc.backgroundImage = UIImage(named: "collection-women")
            }
        case AppData.segueKidsCollection:
            if let vc = segue.destination as? CollectionFullWidthWidget {
                vc.delegate = self
                vc.identifier = AppData.kidsCollectionWidgetIdentifier
                vc.backgroundImage = UIImage(named: "collection-kids")
            }
        case AppData.segueBagsCollection:
            if let vc = segue.destination as? CollectionFullWidthWidget {
                vc.delegate = self
                vc.identifier = AppData.bagsCollectionWidgetIdentifier
                vc.backgroundImage = UIImage(named: "collection-bags")
            }

        default:
            return
        }
    }
}

extension HomeViewController: CollectionWidgetDelegate {
    func viewButtonTapped(identifier: String) {
        if let vc = UIStoryboard(name: "Product", bundle: nil).instantiateInitialViewController() as? ProductListViewController {
            AppData.main?.pushViewController(viewController: vc) { vc in
                if let vc = vc as? ProductListViewController {
                    vc.products = AppData.appDelegate.mockFactory.products
                }
            }
        }
    }
    
}
