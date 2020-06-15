//
//  ProductMockFactory.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/28/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

class ProductMockFactory {
    
    var count: Int
    var products: [Product]
    var categories: [Category]
    
    init(count: Int) {
        self.count = count
        self.products = Self.mockProducts(count: count)
        self.categories = Self.mockCategories()
    }
    
    
    class func mockProducts(count: Int) -> [Product] {
        var products = [Product]()
        
        for _ in 1...count {
            products.append(Product.mockedProducts.randomElement()!)
        }
        
        return products
    }
    
    class func mockCategories() -> [Category] {
        return Category.categories
    }
    
}


