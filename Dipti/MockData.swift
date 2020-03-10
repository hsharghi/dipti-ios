//
//  MockData.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class Models {
    class func generateID(length: Int = 10) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890-"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

class Product: Models {
    internal init(id: String? = nil, image: String, title: String, description: String, designer: String, price: Int = 0, category: Category, options: [ProductOption.Option]? = nil) {
        self.id = id ?? Self.generateID()
        self.image = image
        self.title = title
        self.designer = designer
        self.description = description
        self.price = price
        self.category = category
        self.options = options
    }
    
    var id: String
    var image: String
    var title: String
    var designer: String
    var price: Int
    var description: String
    var category: Category
    var options: [ProductOption.Option]?
    lazy var priceLabel: String  = { [unowned self] in
        return AppHelper.formatPrice(price: self.price, withLocale: "fa_IR", addSuffix: "تومان")
        }()
    
    static let mockedProducts = [
        Product(image: "fake-product-01", title: "دامن صورتی چپ و راستی", description: "", designer: "کوکیاژ", price: 870000, category: .categoryWomenClothSkirt, options: ProductOption.randomOptions(colors: 0, sizes: 4, type: .cloth)),
        Product(image: "fake-product-02", title: "دامن آبی کاربنی پیلی دار", description: "", designer: "لیدا نوبا", price: 1690000, category: .categoryWomenClothSkirt, options: ProductOption.randomOptions(colors: 0, sizes: 4, type: .cloth)),
        Product(image: "fake-product-03", title: "دامن زرد پیلی دار", description: "", designer: "نیلوفر جودت", price: 1260000, category: .categoryWomenClothSkirt, options: ProductOption.randomOptions(colors: 0, sizes: 4, type: .cloth)),
        Product(image: "fake-product-04", title: "جلیقه پافر سرمه ای", description: "", designer: "ای ۸", price: 990000, category: .categoryMenClothSliker, options: ProductOption.randomOptions(colors: 0, sizes: 4, type: .cloth)),
        Product(image: "fake-product-05", title: "بارانی جلو بسته آبی", description: "", designer: "اِنکانتو", price: 1590000, category: .categoryMenClothSliker, options: ProductOption.randomOptions(colors: 0, sizes: 4, type: .cloth)),
        Product(image: "fake-product-06", title: "نيم بوت سرمه ای لنگج", description: "کفش های دست ساز ژین بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است ۲۰ روز کاری برای آماده کردن آن ها زمان نیاز باشد.در صورت مشکل در سایز،کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 850000, category: .categoryMenShoe, options: ProductOption.randomOptions(colors: 0, sizes: 4, type: .shoe)),
        Product(image: "fake-product-07", title: "بوت کردی و جوراب ۲", description: "کفش های دست ساز ژین بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است ۲۰ روز کاری برای آماده کردن آن ها زمان نیاز باشد.در صورت مشکل در سایز،کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 440000, category: .categoryMenShoe, options: ProductOption.randomOptions(colors: 3, sizes: 4, type: .shoe)),
        Product(image: "fake-product-08", title: "کفش پاشنه بلند زرد", description: "کفش های دست ساز آزالی، بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است مدت ۱۰ تا ۱۴ روز برای آماده کردن آن ها زمان نیاز باشد. در صورت مشکل در سایز، کفش برای سایز مناسب قابل تغییر است.", designer: "آزالی", price: 1190000, category: .categoryWomenShoe, options: ProductOption.randomOptions(colors: 4, sizes: 6, type: .shoe)),
        Product(image: "fake-product-09", title: "پاشنه بلند اُپارت", description: "کفش های دست ساز ژین، بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است مدت ۲۰ روز برای آماده کردن آن ها زمان نیاز باشد. در صورت مشکل در سایز، کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 1390000, category: .categoryWomenShoe, options: ProductOption.randomOptions(colors: 4, sizes: 6, type: .shoe)),
        Product(image: "fake-product-10", title: "پاشنه بلند دُرسای یقه‌دار", description: "کفش های دست ساز ژین، بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است مدت ۲۰ روز برای آماده کردن آن ها زمان نیاز باشد. در صورت مشکل در سایز، کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 955000, category: .categoryWomenShoe, options: ProductOption.randomOptions(colors: 5, sizes: 7, type: .cloth)),
        
    ]
    
}


class Category: Models {
    var name: String
    var parent: Category? = nil
    
    internal init(name: String, category: Category? = nil) {
        self.name = name
        self.parent = category
    }
    
    static let categoryWomen = Category(name: "زنانه")
    static let categoryMen = Category(name: "مردانه")
    static let categoryWomenShoe = Category(name: "کفش", category: Category.categoryWomen)
    static let categoryMenShoe = Category(name: "کفش", category: Category.categoryMen)
    static let categoryWomenCloth = Category(name: "لباس", category: Category.categoryWomen)
    static let categoryMenCloth = Category(name: "لباس", category: Category.categoryMen)
    static let categoryWomenClothSkirt = Category(name: "دامن", category: Category.categoryWomenCloth)
    static let categoryMenClothSliker = Category(name: "بارانی", category: Category.categoryMenCloth)
    
    static let categories: [Category] = [
        .categoryWomen,
        .categoryWomenShoe, .categoryWomenCloth, .categoryWomenClothSkirt,
        .categoryMen,
        .categoryMenShoe, .categoryMenCloth, .categoryMenClothSliker
    ]
}

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
