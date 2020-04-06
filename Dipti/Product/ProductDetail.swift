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
    @IBOutlet weak var sizeSelectionButton: UIButton!
    @IBOutlet weak var sizeButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeftOffsetConstraint: NSLayoutConstraint!
    
    
    var product: Product?
    var generalOptions = [String]()
    var sizePickerView: HHPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageView.roundConrners(masks: AppData.allCorners, radius: 10, color: .lightGray)
        sizeSelectionButton.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let product = product {
            setupView(with: product)
        }


        AppData.main?.hideSearch()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppData.main?.showSearch()
    }
       
    
    private func setupView(with product: Product) {
        print("at first: \(sizeButton.frame)")
        colorPicker.isHidden = true
        sizeButton.isHidden = true
        descriptionLabel.text = product.description
        
        for option in product.options ?? [] {
            switch option {
            case .color(let colors):
                colorPicker.isHidden = false
                contentView.layoutIfNeeded()
                colorPicker.colors = colors
                colorPicker.delegate = colorPicker
                colorPicker.dataSource = colorPicker
            case .size(let sizes):
                sizeButton.isHidden = false
                contentView.layoutIfNeeded()
                if sizes.count == 0 {
                    continue
                }
                addSizePickerView(for: sizes)

            case .general(let generalOptions):
                print(generalOptions)
                self.generalOptions = generalOptions
            }
        }
        
        
        
        
    }
    
    private func addSizePickerView(for sizes: [String]) {
        print("while creating: \(sizeButton.frame)")
        sizePickerView = HHPickerView(titles: sizes, hideDuration: 0.6)
        contentView.addSubview(sizePickerView!)
        sizePickerView?.horizontal()
        let convertedOrigin = sizeButton.superview?.convert(sizeButton.frame.origin, to: contentView)
        let frame = CGRect(x: 0, y: (convertedOrigin?.y ?? 0)  - 15, width: view.bounds.width, height: 60)
        sizePickerView?.frame = frame
        sizePickerView?.HHDelegate = self
        sizePickerView?.alpha = 0
    }
    
    @IBAction func selectSizeButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.sizeButton.alpha = 0
        }
        sizePickerView?.showPickerView()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        AppData.cart.add(item: product!)
    }
    
    
}


extension ProductDetailViewController: HHPickerViewDelegate {
    func didSelectItem(_ pickerView: HHPickerView, item: String, at row: Int) {
        sizeButton.setTitle("سایز -  \(item)", for: .normal)
    }
    
    func pickerViewWillHide(_ pickerView: HHPickerView, in: TimeInterval) {
        sizeButton.isEnabled = false
        UIView.animate(withDuration: `in`) {
            self.sizeButton.alpha = 1
        }
    }
    
    func pickerViewDidHide(_ pickerView: HHPickerView) {
        sizeButton.isEnabled = true
    }
}


extension ProductDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 16 {
//            let diff = scrollView.contentOffset.y - 16
//            imageTopConstraint.constant = 16 + diff * 4
//            imageLeftOffsetConstraint.constant = 16 + diff * 4
        } else {
//            imageLeftOffsetConstraint
        }
        print(scrollView.contentOffset.y)
    }
}
