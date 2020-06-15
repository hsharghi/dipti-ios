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
            itemsChanged()
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
            itemsChanged()
            return
        }
        
        items.append(Item(item: item, count: count))
    }
    
    
    func remove(item: Product) {
        items.removeAll(where: {$0.item == item})
    }
    
    func subtract(item: Product, count: Int = 1) {
        if let cartItem = items.filter({$0.item == item}).first {
            cartItem.count -= count
            itemsChanged()
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
    
    private func itemsChanged() {
        delegate?.cartItemsChanged(count: self.totalCount)
    }
    
    
    func createOrder() -> Order {
        let order = Order(id: Int.random(in: 100_000...999_999), checkoutCompletedAt: Date(), number: Models.generateID(), items: createItems(), itemsTotal: totalCount, total: totalValue, state: .new, currencyCode: "TMN", localeCode: "fa_IR", checkoutState: .completed)
        clear()
        return order
    }
    
    private func createItems() -> [OrderItem] {
        return items.compactMap { (item) -> OrderItem in
            let product = item.item
            return OrderItem(id: product.id , quantity: item.count, unitPrice: product.price, total: item.count * product.price, designer: product.designer, productName: product.title, imageName: product.image)
        }
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
