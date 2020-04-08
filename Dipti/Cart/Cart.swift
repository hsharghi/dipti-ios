//
//  Cart.swift
//  Dipti
//
//  Created by Hadi Sharghi on 2/22/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

protocol CartDelegate: class {
    func cartItemsChanged(count: Int)
}

class Cart {
    
    weak var delegate: CartDelegate?
    
    class Item {
        
        internal init(item: Product, count: Int) {
            self.item = item
            self.count = count
        }
        
        var item: Product
        var count: Int
    }
    
    private var items = [Item]() {
        didSet {
            delegate?.cartItemsChanged(count: self.totalCount)
        }
    }
    
    var totalCount: Int {
        var count = 0
        count = items.reduce(count) { (count, item) -> Int in
            return count + item.count
        }
        return count
    }
    
    var uniqueCount: Int {
        return items.count
    }
    
    var totalValue: Int {
        var value = 0
        value = items.reduce(value) { (value, item) -> Int in
            return value + item.count * item.item.price
        }
        return value

    }
    
    func add(item: Product, count: Int = 1) {
        if let item = items.filter({$0.item == item}).first {
            item.count += count
            return
        }
        
        items.append(Item(item: item, count: count))
    }
    
    
    func remove(item: Product) {
        items.removeAll(where: {$0.item == item})
    }
    
    func subtract(item: Product, count: Int = 1) {
        if var cartItem = items.filter({$0.item == item}).first {
            cartItem.count -= count
            if cartItem.count <= 0 {
                self.remove(item: item)
            }
            return
        }
    }
    
    func clear() {
        items.removeAll()
    }
    
    func list() -> [Item] {
        return items
    }
    
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
