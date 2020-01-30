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
        
        productImageView.roundConrners(masks: AppData.allCorners, radius: 10, color: .clear)
        
        
    }
    
    
    private func setupView(with product: Product) {
        
        
        
    }
    
    
}
