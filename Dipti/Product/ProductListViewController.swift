//
//  ProductListViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 0)
        collectionView.backgroundColor = AppData.color.veryLightGray
    }
    
    
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        
        cell.setupCell(product: products[indexPath.item])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = (width - 10) / 2
        return CGSize(width: cellWidth, height: (cellWidth * 3 / 2) - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProductDetail", sender: products[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetail",
            let vc = segue.destination as? ProductDetailViewController,
            let product = sender as? Product {
            vc.product = product
        }
    }
}



class ProductListCell: UICollectionViewCell {
    
    static let identifier = "productListCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
        
    func setupCell(product: Product) {
        contentView.backgroundColor = .white
        contentView.roundConrners(masks: AppData.allCorners, radius: 8, color: .clear)
        imageView.image = UIImage(named: product.image)
        imageView.layer.borderWidth = 0.5
        imageView.roundConrners(masks: AppData.allCorners, radius: 10, color: .gray)
        titleLabel.text = product.title
        designerName.text = product.designer
        priceLabel.text = product.priceLabel
    }
    
    
}
