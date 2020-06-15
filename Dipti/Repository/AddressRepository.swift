//
//  AddressRepository.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/15/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

class AddressRepository {
    
    class func list() -> [Address] {
        AppData.addresses.sorted(by: {$0.createdAt > $1.createdAt})
    }
    
    
    class func add(address: Address) -> Address {
        var addresses = AppData.addresses
        address.createdAt = Date()
        address.updatedAt = Date()
        
        addresses.append(address)
        AppData.addresses = addresses
        
        return address
    }
    
    class func update(address: Address) -> Address {
        var addresses = AppData.addresses
        if let oldAddress = addresses.filter({$0.id == address.id}).first {
            address.updatedAt = Date()
            addresses.replace(object: oldAddress, with: address)
            AppData.addresses = addresses
        }
        
        return address
    }
    
    class func remove(address: Address) {
            var addresses = AppData.addresses
            addresses.remove(object: address)
            AppData.addresses = addresses
    }
    
    class func remove(id: Int) {
        if let address = AppData.addresses.filter({$0.id == id}).first {
            Self.remove(address: address)
        }
    }
    
    
}
