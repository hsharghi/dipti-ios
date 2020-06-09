//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class Product: Models {
    internal init(id: String? = nil,
                  image: String,
                  title: String,
                  description: String,
                  designer: String,
                  price: Int = 0,
                  category: Category,
                  options: [ProductOption.Option]? = nil) {
        
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
        return AppHelper.formatNumber(number: self.price, withLocale: "fa_IR", addSuffix: "تومان")
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
    
    static var allColors: [UIColor] {
        var colors = [UIColor]()
        _ = Product.mockedProducts.forEach { (product) in
            product.options?.forEach({ (option) in
                switch option {
                case .color(let colorOptions):
                    colors.append(contentsOf: colorOptions)
                default: break
                }
            })
        }
        return colors
    }
    
    static var allClothSizes: [String] {
        var sizes = [String]()
        _ = Product.mockedProducts.forEach { (product) in
            product.options?.forEach({ (option) in
                switch option {
                case .size(let sizeOptions):
                    sizes.append(contentsOf: sizeOptions.filter({!$0.isNumeric}))
                default: break
                }
            })
        }
        return sizes
    }

    static var allShoeSizes: [String] {
        var sizes = [String]()
        _ = Product.mockedProducts.forEach { (product) in
            product.options?.forEach({ (option) in
                switch option {
                case .size(let sizeOptions):
                    sizes.append(contentsOf: sizeOptions.filter({$0.isNumeric}))
                default: break
                }
            })
        }
        return sizes
    }

}


