//
//  CacheManager.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/23/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation
import Cachy

class CachyCacheManager: CacheManager {
    
    func get<T>(key: String, as: T.Type) -> T? {
        guard let value = getCache(key: key) as? T else {
            return nil
        }
        
        return value
    }
    
    func get<T>(key: String, as: T.Type, _ calculate: @escaping () -> T?) -> T? {
        if let value = getCache(key: key) as? T {
            return value
        }
        
        let value = calculate()
        set(value: value, for: key)
        return value
    }
    
    func set<T>(value: T, for key: String, expire: Date? = nil) {
        Cachy.shared.add(object: CachyObject(value: value as AnyObject, key: key, expirationDate: expire))
    }
    
    func delete(key: String) {
        Cachy.shared.removeObject(forKey: key as AnyObject)
    }
    
    private func getCache(key: String) -> Any? {
        return Cachy.shared.get(forKey: key)
    }
    
}
