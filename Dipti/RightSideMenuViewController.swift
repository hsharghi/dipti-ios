//
//  RightSideMenuViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/19/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class RightSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatar: UIButton!
    
    var menuState: SideMenuFactory.MenuState = .notLoggedIn
    var menuItems: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = SideMenuFactory.shared.menuItems(for: .notLoggedIn)
        
        tableView.tableFooterView = UIView()
        
        avatar.rounded(color: .brown, width: 2)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMenu), name: NSNotification.Name(rawValue: AppData.loginStatusNotificationKey), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: index, animated: false)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = SideMenuData.rightMenuCellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RightSideMenuTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(with: menuItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem  = menuItems[indexPath.row]

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppData.sideMenuSelectNotificationKey), object: nil, userInfo: menuItem)
        dismiss(animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    @objc func reloadMenu() {
//        loadMenuItems()
//        profileInfoTableView.reloadData()
    }
}


class RightSideMenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    func setupCell(with data: [String: Any]) {
        if let title = data["title"] as? String {
            self.itemLabel.text = title
        }
        
        if let icon = data["icon"] as? String {
            self.iconImageView.image = UIImage(named: "menu-" + icon)
        }
        
    }
    
}
