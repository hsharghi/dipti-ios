//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


class ProductOption: Models {
    
    enum Option {
        case color(_ color: [UIColor])
        case size(_ size: [String])
        case general(_ options: [String])
    }
    
    enum SizeType {
        case shoe
        case cloth
    }
    
    var id: String
    var options: [Option]
    
    class func randomOptions(colors: Int, sizes: Int, type: SizeType) -> [Option] {
        var options = [Option]()
        if colors > 0 {
            options.append(.color(randomColors(count: colors)))
        }
        
        if sizes > 0 {
            if type == .cloth {
                options.append(.size(randomClothSize(maxCount: sizes)))
            }
            if type == .shoe {
                options.append(.size(randomShoeSize(maxCount: sizes)))
            }
        }
        
        return options
    }
    
    static let clothSizes = [
        0:"XXS", 1:"XS", 2:"S", 3:"M", 4:"L", 5:"XL", 6:"XXL", 7:"XXXL"
    ]
    
    static let shoeSizes = [
        0:"36", 1:"38", 2:"40", 3:"42", 4:"44", 5:"45"
    ]
    
    init(id: String? = nil, options: [Option]) {
        self.id = id ?? Self.generateID()
        self.options = options
    }
    
    class func randomColors(count: Int) -> [UIColor] {
        var colors = [UIColor]()
        for _ in 0..<count {
            colors.append(UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1))
        }
        return colors
    }
    
    class func randomClothSize(maxCount: Int) -> [String] {
        var sizes = ProductOption.clothSizes
        guard maxCount > 0 && maxCount < sizes.count else {
            return sizes.sorted(by: <).compactMap({$0.value})
        }
        
        repeat {
            if let key = sizes.randomElement()?.key,
                let index = sizes.index(forKey: key) {
                sizes.remove(at: index)
            }
        } while (sizes.count > maxCount)
        return sizes.sorted(by: <).compactMap({$0.value})
    }
    
    
    class func randomShoeSize(maxCount: Int) -> [String] {
        var sizes = ProductOption.shoeSizes
        guard maxCount > 0 && maxCount < sizes.count else {
            return sizes.sorted(by: <).compactMap({$0.value})
        }
        
        repeat {
            if let key = sizes.randomElement()?.key,
                let index = sizes.index(forKey: key) {
                sizes.remove(at: index)
            }
        } while (sizes.count > maxCount)
        return sizes.sorted(by: <).compactMap({$0.value})
    }
}

