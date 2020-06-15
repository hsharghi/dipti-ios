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
    
    private var selectedProduct: Product?
    private var selectedFrame : CGRect?
    private var customInteractor : CustomInteractor?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 0)
        collectionView.backgroundColor = AppData.color.veryLightGray
        
        self.navigationController?.delegate = self
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProductListCell else { return }
        self.selectedProduct = products[indexPath.row]
        selectedFrame = cell.imageView.superview?.convert(cell.imageView.frame, to: collectionView.superview)
        showProductDetail(with: products[indexPath.item])
//        performSegue(withIdentifier: "showProductDetail", sender: products[indexPath.item])
    }
    
    private func showProductDetail(with product: Product) {
        guard let detailVC: ProductDetailViewController = storyboard?.instantiateVC() else { return }        
        detailVC.product = product
        AppData.main?.pushViewController(viewController: detailVC)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetail",
            let vc = segue.destination as? ProductDetailViewController,
            let product = sender as? Product {
            vc.product = product
        }
    }
}

extension ProductListViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        guard let product = self.selectedProduct else { return nil }
        guard let image = product.uiImage() else { return nil }
        
        guard (fromVC as? ProductDetailViewController != nil && toVC as? ProductListViewController != nil) ||
        (fromVC as? ProductListViewController != nil && toVC as? ProductDetailViewController != nil) else {
            return nil
        }
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            return PopDetailImageAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: frame, image: image)
        default:
            return PopDetailImageAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame, image: image)
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
        contentView.roundConrners(masks: .allCorners, radius: 8, color: .clear)
        imageView.image = UIImage(named: product.image)
        imageView.layer.borderWidth = 0.5
        imageView.roundConrners(masks: .allCorners, radius: 10, color: .gray)
        titleLabel.text = product.title
        designerName.text = product.designer
        priceLabel.text = product.priceLabel
    }
    
    
}
