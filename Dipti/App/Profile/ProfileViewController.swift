//
//  ProfileViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/15/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol UpdateProfile: class {
    func profileUpdated()
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateProfileData()
        AppData.main?.hideSearch()
    }
    
    private func populateProfileData() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditProfileViewController {
            vc.delegate = self
        }
    }
    
}

extension ProfileViewController: UpdateProfile {
    func profileUpdated() {
        populateProfileData()
    }
    
}
