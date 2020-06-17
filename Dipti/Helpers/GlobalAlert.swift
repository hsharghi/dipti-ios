//
//  GlobalAlert.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/17/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class GlobalAlert {
    
    internal static var alertMessageController:UIAlertController!
    
    internal static func displayAlert(alert: UIAlertController, completion: (() -> Void)? = nil) {
        
        Self.alertMessageController = alert
        
        if let controller = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
            controller.present(Self.alertMessageController, animated: true, completion: completion)
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let controller = appDelegate.window?.rootViewController {
                controller.present(Self.alertMessageController, animated: true, completion: completion)
            }
        }
        
        return
    }

}
