//
//  MockData.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

class Product {
    internal init(image: String, title: String, description: String, designer: String, price: Int = 0, category: Category) {
        self.image = image
        self.title = title
        self.designer = designer
        self.description = description
        self.price = price
        self.category = category
    }
    
    var image: String
    var title: String
    var designer: String
    var price: Int
    var description: String
    var category: Category
    lazy var priceLabel: String  = { [unowned self] in
        return AppHelper.formatPrice(price: self.price, withLocale: "fa_IR", addSuffix: "تومان")
    }()
    
    static let mockedProducts = [
        Product(image: "fake-product-01", title: "دامن صورتی چپ و راستی", description: "", designer: "کوکیاژ", price: 870000, category: .categoryWomenClothSkirt),
        Product(image: "fake-product-02", title: "دامن آبی کاربنی پیلی دار", description: "", designer: "لیدا نوبا", price: 1690000, category: .categoryWomenClothSkirt),
        Product(image: "fake-product-03", title: "دامن زرد پیلی دار", description: "", designer: "نیلوفر جودت", price: 1260000, category: .categoryWomenClothSkirt),
        Product(image: "fake-product-04", title: "جلیقه پافر سرمه ای", description: "", designer: "ای ۸", price: 990000, category: .categoryMenClothSliker),
        Product(image: "fake-product-05", title: "بارانی جلو بسته آبی", description: "", designer: "اِنکانتو", price: 1590000, category: .categoryMenClothSliker),
        Product(image: "fake-product-06", title: "نيم بوت سرمه ای لنگج", description: "کفش های دست ساز ژین بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است ۲۰ روز کاری برای آماده کردن آن ها زمان نیاز باشد.در صورت مشکل در سایز،کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 850000, category: .categoryMenShoe),
        Product(image: "fake-product-07", title: "بوت کردی و جوراب ۲", description: "کفش های دست ساز ژین بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است ۲۰ روز کاری برای آماده کردن آن ها زمان نیاز باشد.در صورت مشکل در سایز،کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 440000, category: .categoryMenShoe),
        Product(image: "fake-product-08", title: "کفش پاشنه بلند زرد", description: "کفش های دست ساز آزالی، بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است مدت ۱۰ تا ۱۴ روز برای آماده کردن آن ها زمان نیاز باشد. در صورت مشکل در سایز، کفش برای سایز مناسب قابل تغییر است.", designer: "آزالی", price: 1190000, category: .categoryWomenShoe),
        Product(image: "fake-product-09", title: "پاشنه بلند اُپارت", description: "کفش های دست ساز ژین، بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است مدت ۲۰ روز برای آماده کردن آن ها زمان نیاز باشد. در صورت مشکل در سایز، کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 1390000, category: .categoryWomenShoe),
        Product(image: "fake-product-10", title: "پاشنه بلند دُرسای یقه‌دار", description: "کفش های دست ساز ژین، بر اساس سفارش شما درست می شوند و به همین دلیل ممکن است مدت ۲۰ روز برای آماده کردن آن ها زمان نیاز باشد. در صورت مشکل در سایز، کفش برای سایز مناسب قابل تغییر است.", designer: "ژین", price: 955000, category: .categoryWomenShoe),

    ]
    
}


class Category {
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
