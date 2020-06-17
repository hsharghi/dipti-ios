//
//  ProfileViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/15/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = (AppData.customer?.firstName ?? "") + " " + (AppData.customer?.lastName ?? "")
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        AppHelper.logout()
    }
    
    @IBAction func showAddresses(_ sender: Any) {
        AppHelper.showAddresses(in: self)
    }
    
    @IBAction func showFavorites(_ sender: Any) {
        
    }
    
}
