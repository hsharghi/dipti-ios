//
//  ProductDetail.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/27/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var designerName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favButton: UIImageView!
    
    var product: Product? {
        didSet {
            if let product = product {
                setupView(with: product)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageView.roundConrners(masks: AppData.allCorners, radius: 10, color: .lightGray)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppData.main?.hideSearch()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        AppData.main?.hideSearch()
//    }
//
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppData.main?.showSearch()
    }
    
    
    private func setupView(with product: Product) {
        
        
        
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        AppData.cart.add(item: product!)
    }
    
}