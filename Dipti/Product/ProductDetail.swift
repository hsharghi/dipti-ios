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
    @IBOutlet weak var colorPicker: ColorPickerCollectionView!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = product {
            setupView(with: product)
        }

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
        
        for option in product.options ?? [] {
            switch option {
            case .color(let colors):
                colorPicker.colors = colors
                colorPicker.delegate = colorPicker
                colorPicker.dataSource = colorPicker
            case .size(let sizes):
                print(sizes)
            
            case .general(let generalOptions):
                print(generalOptions)
            }
        }
        
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        AppData.cart.add(item: product!)
    }
    
}
