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
    
    static let shared = SideMenuFactory(data: nil)
    
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
    
    func showRightSideMenu(in viewController: UIViewController) {
        if let menu = SideMenuManager.default.rightMenuNavigationController {
            viewController.present(menu, animated: true, completion: nil)
        }
    }

    func showLeftSideMenu(in viewController: UIViewController) {
        if let menu = SideMenuManager.default.leftMenuNavigationController {
            viewController.present(menu, animated: true, completion: nil)
        }
    }

    func setLeftMenu(storyboardId: String = "LeftSideMenuViewController") {
        SideMenuManager.default.leftMenuNavigationController = menuNavigationController(storyboardId: storyboardId)
        SideMenuManager.default.leftMenuNavigationController?.settings = makeMenuSettings()
    }
    
    func setRightMenu(storyboardId: String = "RightSideMenuViewController") {
        SideMenuManager.default.rightMenuNavigationController = menuNavigationController(storyboardId: storyboardId)
        SideMenuManager.default.rightMenuNavigationController?.settings = makeMenuSettings()
    }
    
    
    
    private func menuNavigationController(storyboardId: String) -> SideMenuNavigationController? {
        let a = UIStoryboard(name: SideMenuFactory.storybord, bundle: nil).instantiateViewController(identifier: storyboardId) as? SideMenuNavigationController
        return a
    }
    
    
    private static func loadSideMenuItems() -> [String: Any] {
        
        if let path = Bundle.main.path(forResource: SideMenuFactory.sideMenuPlist, ofType: "plist"), let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
            return dic
        }
        
        return [:]
    }
    
    
    private func makeMenuSettings() -> SideMenuSettings {
        let presentationStyle: SideMenuPresentationStyle = .menuSlideIn
        presentationStyle.backgroundColor = UIColor.black
        presentationStyle.presentingScaleFactor = 1

        var settings = SideMenuSettings()
        settings.presentDuration = 0.35
        settings.presentationStyle = presentationStyle
//        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = nil

        return settings
    }
    
    
    
}
