//
//  PaymentWebViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import WebKit

class PaymentViewController: UIViewController {
    
    var order: Order!
    
    override func viewDidLoad() {
        [100, 101].forEach({view.viewWithTag($0)?.roundConrners(masks: .allCorners, radius: 10)})
    }
    
    @IBAction func payButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppData.orderPaidNotificationKey), object: nil, userInfo: ["order": order!])
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppData.orderCanceledNotificationKey), object: nil, userInfo: ["order": order!])
        dismiss(animated: true)
    }
    
}
