//
//  OrderDetailVIewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/14/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var order: Order!
    var designers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "سفارش \(order.number)"
        orderDate.text = AppHelper.formatDate(order.checkoutCompletedAt, format: "dd MMM yyyy - ساعت HH:mm", addPrefix: "تاریخ سفارش: ")
        designers = Array(Dictionary(grouping: order.items, by: {$0.designer ?? ""}).keys)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return designers.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.items.filter({$0.designer == designers[section]}).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: OrderItemTableViewCell.ID, for: indexPath) as? OrderItemTableViewCell {
            
            let items = order.items.filter({$0.designer == designers[indexPath.section]})
            cell.selectionStyle = .none
            cell.item = items[indexPath.row]
            return cell
        }
        
        fatalError("no order item cell")
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = Bundle.main.loadNibNamed(String(describing: OrderDetailHeaderView.self), owner: self, options: nil)?[0] as? OrderDetailHeaderView {
        view.designerName.text = designers[section]
            view.designerImage.rounded(color: AppData.color.gray, width: 1)
            view.votesCountLabel.text = "(\(Int.random(in: 5...200)))".toFa()
        return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let view = Bundle.main.loadNibNamed(String(describing: OrderDetailFooterView.self), owner: self, options: nil)?[0] as? OrderDetailFooterView {
        return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }

}


class OrderItemTableViewCell: UITableViewCell {
    
     static let ID = "orderItemCell"
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    var item: OrderItem? {
        didSet {
            if let item = item {
                productTitle.text = item.id
                price.text = AppHelper.formatNumber(item.unitPrice, withLocale: "fa_IR", addSuffix: "تومان ")
                countLabel.text =  AppHelper.formatNumber(item.quantity, withLocale: "fa_IR", addSuffix: " عدد")
                statusLabel.text = ["درحال بررسی", "درحال آماده سازی", "آماده ارسال"].randomElement()
                productImage.image = Product.mockedProducts.filter({$0.id == item.id}).first?.uiImage()
            }
        }
    }
    
}


class OrderDetailHeaderView: UIView {
    
    @IBOutlet weak var designerName: UILabel!
    @IBOutlet weak var designerImage: UIImageView!
    @IBOutlet weak var votesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundConrners(masks: .topCorners, radius: 20)

        
    }
    
}

class OrderDetailFooterView: UIView {
    @IBOutlet weak var followUpButton: UIButton!
    @IBOutlet weak var whiteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whiteView.roundConrners(masks: .bottomCorners, radius: 20)
    }
}
