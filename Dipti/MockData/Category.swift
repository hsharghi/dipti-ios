//
//  Models.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/9/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class Category: Models, Equatable {
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name && lhs.parent == rhs.parent
    }
    
    var name: String
    var icon: UIImage?
    var parent: Category? = nil
    
    internal init(name: String, parent: Category? = nil, icon: UIImage? = nil) {
        self.name = name
        self.parent = parent
        self.icon = icon
    }
    
    static let categoryWomen = Category(name: "زنانه")
    static let categoryMen = Category(name: "مردانه")
    static let categoryWomenShoe = Category(name: "کفش", parent: Category.categoryWomen, icon: UIImage(named: "category-shoe"))
    static let categoryMenShoe = Category(name: "کفش", parent: Category.categoryMen)
    static let categoryWomenCloth = Category(name: "لباس", parent: Category.categoryWomen, icon: UIImage(named: "category-cloth"))
    static let categoryMenCloth = Category(name: "لباس", parent: Category.categoryMen)
    static let categoryWomenClothSkirt = Category(name: "دامن", parent: Category.categoryWomenCloth, icon: UIImage(named: "category-cloth"))
    static let categoryMenClothSliker = Category(name: "بارانی", parent: Category.categoryMenCloth)
    static let categoryWomenBag = Category(name: "کیف", parent: Category.categoryWomen, icon: UIImage(named: "category-bag"))
    static let categoryWomenAccessory = Category(name: "اکسسوری", parent: Category.categoryWomen, icon: UIImage(named: "category-accessory"))

    static let categories: [Category] = [
        .categoryWomen,
        .categoryWomenShoe, .categoryWomenCloth, .categoryWomenClothSkirt,
        .categoryMen,
        .categoryMenShoe, .categoryMenCloth, .categoryMenClothSliker
    ]
}
