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
    private static let loginTokenDataKey = "loginTokenDataKey"
    static let sideMenuSelectNotificationKey = "sideMenuSelectNotificationKey"
    static let searchFilterNotificationKey = "searchFilterNotificationKey"
    
    // temporary
    static let orderPaidNotificationKey = "orderPaidNotificationKey"
    static let orderCanceledNotificationKey = "orderCanceledNotificationKey"
    private static let customerDataKey = "customerDataKey"
    private static let ordersDataKey = "ordersDataKey"
    private static let addressesDataKey = "addressesDataKey"

    ////////////////////////
    /// HomeViewController
    ////////////////////////
    static let segueMenCollection = "embedCollectionMen"
    static let segueWomenCollection = "embedCollectionWomen"
    static let segueKidsCollection = "embedCollectionKids"
    static let segueBagsCollection = "embedCollectionBags"

    static let menCollectionWidgetIdentifier = "menCollectionWidget"
    static let womenCollectionWidgetIdentifier = "womenCollectionWidget"
    static let kidsCollectionWidgetIdentifier = "kidsCollectionWidget"
    static let bagsCollectionWidgetIdentifier = "bagsCollectionWidget"

    struct color {
        static let yellow = UIColor(hexString: "F7C200")
        static let gray = UIColor(hexString: "D8D8D8")
        static let veryLightGray = UIColor(hexString: "F2F2F2")
        static let lightGray = UIColor(hexString: "F3F4F6")
        static let darkBlue = UIColor(hexString: "515C6F")
    }
    
    
    static let forgetPasswordResponse = """
لینک بازیابی رمز عبور شما به آدرس ایمیل وارد شده ارسال شد.
 لطفا به ایمیل خود مراجعه کنید و بر روی لینک فرستاده شده بزنید تا به صحفه بازیابی رمز عبور هدایت شوید.
"""
 
    static var cacheManager: CacheManager {
        return CachyCacheManager()
    }
    
    static var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    static var main: MainViewController? {
        get {
            return appDelegate.mainViewController
        }
        set(mainViewController) {
            appDelegate.mainViewController = mainViewController
        }
    }
    
    static var cart: Cart {
        get {
            return appDelegate.cart
        }
    }
    
    static var isUserLoggedIn: Bool {
        get {
            return appDelegate.loginToken != nil
                && !appDelegate.loginToken!.isEmpty
        }
    }
    
    static var loginToken: String? {
        get {
            if let data = UserDefaults.standard.string(forKey: loginTokenDataKey) {
                return data
            }
            return nil
        }
        
        set(token) {
            UserDefaults.standard.set(token, forKey: loginTokenDataKey)
            appDelegate.loginToken = token
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppData.loginStatusNotificationKey),
                                            object: nil,
                                            userInfo: nil)
        }
    }
    
    static var customer: Customer? {
        get {
            if let data  = UserDefaults.standard.data(forKey: ordersDataKey)
            {
                do {
                    return try Customer(data: data)
                } catch {
                    print(error)
                    return nil
                }
            }
            return nil
        }
        
        set(customer) {
            do {
                let data = try customer?.jsonData()
                UserDefaults.standard.set(data, forKey: customerDataKey)
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
    }
    
    static var registeredCustomers: [Customer] {
        get {
            if let arrayOfJson  = UserDefaults.standard.array(forKey: customerDataKey + "s") as? [String]
            {
                do {
                    return try arrayOfJson.compactMap({try Customer($0)})
                } catch {
                    print(error)
                    return []
                }
            }
            return []
        }
        
        set(customers) {
            do {
                let arrayOfJson = try customers.compactMap({try $0.jsonString()})
                UserDefaults.standard.set(arrayOfJson, forKey: customerDataKey + "s")
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
    }
    
    static var orders: [Order] {
        get {
            if let arrayOfJson  = UserDefaults.standard.array(forKey: ordersDataKey) as? [String]
            {
                do {
                    return try arrayOfJson.compactMap({try Order($0)}).sorted(by: {$0.checkoutCompletedAt > $1.checkoutCompletedAt})
                } catch {
                    print(error)
                    return []
                }
            }
            return []
        }
        
        set(orders) {
            do {
                let arrayOfJson = try orders.compactMap({try $0.jsonString()})
                UserDefaults.standard.set(arrayOfJson, forKey: ordersDataKey)
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
    }

    static var filter: SearchFilter {
        get {
            return appDelegate.searchFilter
        }
        
        set(newFilter) {
            appDelegate.searchFilter = newFilter
        }
    }
    
    
    static var addresses: [Address] {
        get {
            if let arrayOfJson  = UserDefaults.standard.array(forKey: addressesDataKey) as? [String]
            {
                do {
                    return try arrayOfJson.compactMap({try Address($0)})
                } catch {
                    print(error)
                    return []
                }
            }
            return []
        }
        
        set(addresses) {
            do {
                let arrayOfJson = try addresses.compactMap({try $0.jsonString()})
                UserDefaults.standard.set(arrayOfJson, forKey: addressesDataKey)
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
    }

    
}
