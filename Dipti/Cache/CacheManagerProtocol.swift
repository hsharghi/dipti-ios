//
//  CacheManagerProtocol.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/23/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation


protocol CacheManager {
    func get<T>(key: String, as: T.Type) -> T?
    func get<T>(key: String, as: T.Type, _ calculate: @escaping () -> T?) -> T?
    func set<T>(value: T, for key: String, expire: Date?)
    func delete(key: String)
}
