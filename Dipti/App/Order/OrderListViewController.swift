//
//  OrderListViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/14/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


class OrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var orderType: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var orders: [Order]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orders = AppData.orders
        let attributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansWeb-Bold", size: 18)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: OrderListTableViewCell.ID, for: indexPath) as? OrderListTableViewCell {
            cell.order = orders[indexPath.row]
            return cell
        }
        
        fatalError("no order cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let vc = segue.destination as? OrderDetailViewController {
                vc.order = orders[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
}


class OrderListTableViewCell: UITableViewCell {
    
    static let ID = "orderCell"
    
     @IBOutlet weak var thumbnail: UIImageView!
     @IBOutlet weak var orderNumber: UILabel!
     @IBOutlet weak var orderStatus: UILabel!
     @IBOutlet weak var orderTotal: UILabel!

     
    var order: Order? {
        didSet {
            if let order = order {
                thumbnail.image = CollageImage.collage(rect: thumbnail.bounds, images: order.images())
                orderNumber.text = order.number
                orderStatus.text = order.statusToText()
                orderTotal.text = AppHelper.formatNumber(order.total, withLocale: "fa_IR", addSuffix: " تومان")
            }
        }
    }
 
    
}

extension Order {
    func images() -> [UIImage] {
        return self.items.compactMap({UIImage(named: $0.imageName ?? "")})
    }
}
