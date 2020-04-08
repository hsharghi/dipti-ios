//
//  SearchResultTableViewCells.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/8/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


class SearchProductCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var designerName: UILabel!
    
    var product: Product? {
        didSet {
            if let product = product {
                thumbnail.image = product.uiImage()
                productTitle.text = product.title
                designerName.text = product.designer
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnail.rounded(color: .lightGray)
    }
    
}


class SearchCategoryCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    var category: Category? {
        didSet {
            if let category = category {
                categoryTitle.text = category.name
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnail.rounded(color: .lightGray)
    }
    
}


class SearchDesignerCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var designerName: UILabel!
    
    var designer: String? {
        didSet {
            if let designer = designer {
                designerName.text = designer
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnail.rounded(color: .lightGray)
    }
    
}
