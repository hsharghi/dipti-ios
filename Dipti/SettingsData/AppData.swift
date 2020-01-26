//
//  AppData.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/19/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

final class AppData {
    
    static let showIntroKey = "showIntro"
    static let loginStatusNotificationKey = "loginStatusNotificationKey"
    static let sideMenuSelectNotificationKey = "sideMenuSelectNotificationKey"
    
    
    struct color {
        static let yellow = UIColor(hexString: "F7C200")
        static let gray = UIColor(hexString: "D8D8D8")
        static let lightGray = UIColor(hexString: "F3F4F6")
        static let darkBlue = UIColor(hexString: "515C6F")
    }
 
    static var cacheManager: CacheManager {
        return CachyCacheManager()
    }
}
