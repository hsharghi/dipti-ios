//
//  CartViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/8/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        //        checkoutButton.roundConrners(masks: .allCorners, radius: 10)
        checkoutButton.rounded(color: .clear, width: 0)
        updateTotalValue()
    }
    
    private func updateTotalValue() {
        let total = AppData.cart.totalValue
        cartTotalLabel.text = AppHelper.formatNumber(number: total, withLocale: "fa_IR", addSuffix: "تومان")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.cart.uniqueCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartItemCell.self), for: indexPath) as! CartItemCell
        
        cell.item = AppData.cart.list()[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "حذف") { (action, indexPath) in
            let cartItem = AppData.cart.list()[indexPath.row]
            
            AppHelper.showAlert("حذف", message: "آیا این کالا از سبد خرید حذف شود؟", actions: [
                UIAlertAction(title: "بله", style: .destructive, handler: { (action) in
                    AppData.cart.remove(item: cartItem.item)
                    self.updateTotalValue()
                }),
                UIAlertAction(title: "خیر", style: .cancel)
            ])
        }
        
        return [delete]
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension CartViewController: CartItemDelegate {
    func plusButtonTapped(on cell: CartItemCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let cartItem = AppData.cart.list()[indexPath.row]
        AppData.cart.add(item: cartItem.item)
        updateTotalValue()
        
    }
    
    func minusButtonTapped(on cell: CartItemCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let cartItem = AppData.cart.list()[indexPath.row]
        
        if cartItem.count == 1 {
            AppHelper.showAlert("حذف", message: "آیا این کالا از سبد خرید حذف شود؟", actions: [
                UIAlertAction(title: "بله", style: .destructive, handler: { (action) in
                    AppData.cart.subtract(item: cartItem.item)
                    self.updateTotalValue()
                }),
                UIAlertAction(title: "خیر", style: .cancel)
            ])
            return
        }
        AppData.cart.subtract(item: cartItem.item)
        updateTotalValue()
        
    }
    
    
}






protocol CartItemDelegate: class {
    func plusButtonTapped(on cell: CartItemCell)
    func minusButtonTapped(on cell: CartItemCell)
}

class CartItemCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var designer: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    weak var delegate: CartItemDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        plusButton.rounded(color: .lightGray)
        minusButton.rounded(color: .lightGray)
        productImage.rounded(color: .lightGray)
        
        
    }
    
    var item: Cart.Item? {
        didSet {
            if let cart = item {
                productImage.image = cart.item.uiImage()
                productTitle.text = cart.item.title
                designer.text = cart.item.designer
                price.text = cart.item.priceLabel
                countLabel.text =  AppHelper.formatNumber(number: cart.count, withLocale: "fa_IR", addSuffix: " عدد")
            }
        }
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        delegate?.plusButtonTapped(on: self)
    }
    
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        delegate?.minusButtonTapped(on: self)
    }
    
}
