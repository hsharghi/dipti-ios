//
//  SideMenuFactory.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/19/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SideMenu

final class SideMenuFactory {
    
    enum MenuState: String {
        case loggedIn = "loggedInItems"
        case notLoggedIn = "notLoggedInItems"
    }
    
    static let storybord = "SideMenu"
    static let storybordId = "SideMenuNavigationController"
    
    static let shared = SideMenuFactory()
    
    init(data: [String: Any]? = nil) {
        if data == nil {
            self.menuData = SideMenuFactory.loadSideMenuItems()
            return
        }
        self.menuData = data!
    }
    
    func menuItems(for state: MenuState) -> [[String: Any]] {
        if let items = menuData[state.rawValue] as? [[String: Any]] {
            return items.sorted(by: { (aDic, bDic) -> Bool in
                let s1 = aDic["sortOrder"] as? Int ?? 0
                let s2 = bDic["sortOrder"] as? Int ?? 0
                return s1 < s2
            })
        }
        
        return []
    }
    
    private let menuData: [String: Any]
    static let sideMenuPlist = "sideMenu"
    
    
    func setLeftMenu(storyboardId: String = "LeftSideMenuViewController") {
        SideMenuManager.default.leftMenuNavigationController = menuNavigationController(storyboardId: storyboardId)
    }
    
    func setRightMenu(storyboardId: String = "RightSideMenuViewController") {
        SideMenuManager.default.rightMenuNavigationController = menuNavigationController(storyboardId: storyboardId)
    }
    
    
    
    private func menuNavigationController(storyboardId: String) -> SideMenuNavigationController? {
        return UIStoryboard(name: SideMenuFactory.storybord, bundle: nil).instantiateViewController(identifier: storyboardId) as? SideMenuNavigationController
    }
    private static func loadSideMenuItems() -> [String: Any] {

        if let path = Bundle.main.path(forResource: SideMenuFactory.sideMenuPlist, ofType: "plist"), let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                return dic
        }

        return [:]
    }
    
    

    
}
