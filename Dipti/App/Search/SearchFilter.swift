//
//  SearchFilter.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/8/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class SearchFilter {
    
    var minPrice: Int = 0
    var maxPrice: Int = 0
    var categories: [Category] = []
    var colors: [UIColor] = []
    var shoeSizes: [String] = []
    var clothSizes: [String] = []
    
    
    func isClear() -> Bool {
        return minPrice == 0 && maxPrice == 0 && categories.isEmpty
            && colors.isEmpty && shoeSizes.isEmpty && clothSizes.isEmpty
    }
    
    func clear() {
        minPrice = 0
        maxPrice = 0
        categories = []
        colors = []
        shoeSizes = []
        clothSizes = []
        filterChanged()
    }
    
    func setPriceFilter(min: CGFloat? = nil, max: CGFloat? = nil) {
        if let min = min {
            self.minPrice = Int(min)
        }
        if let max = max {
            self.maxPrice = Int(max)
        }
        
        filterChanged()
    }
    
    func setCategory(categories: [Category]) {
        self.categories = categories
        filterChanged()
    }
    
    func setColor(colors: [UIColor]) {
        self.colors = colors
        filterChanged()
    }
    
    func setClothSize(sizes: [String]) {
        self.clothSizes = sizes
        filterChanged()
    }
    
    func setShoeSize(sizes: [String]) {
        self.shoeSizes = sizes
        filterChanged()
    }
    
    
    private func filterChanged() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppData.searchFilterNotificationKey), object: nil)
    }
    
    
}
