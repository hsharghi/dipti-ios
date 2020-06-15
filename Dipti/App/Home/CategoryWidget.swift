//
//  CategoryWidget.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/31/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class CategoryWidget: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var categories: [Category] = []
    
    var numberOfCategories: Int = 6 {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateCategories()
    }
    
    private func generateCategories() {
        categories.removeAll()
        categories.append(contentsOf: [.categoryWomenBag, .categoryWomenAccessory, .categoryWomenCloth, .categoryWomenShoe])
        collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell {
            cell.category = categories[indexPath.item]
            return cell
        }
        
        fatalError("Category cell not found")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.width - 3 * 8) / 2
        let height = (self.view.bounds.height - 3 * 8) / 2
        
        return CGSize(width: width, height: height)
    }

}


class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var category: Category? {
        didSet {
            if let category = category {
                imageView.image = category.icon
                name.text = category.name
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.roundConrners(masks: .allCorners, radius: 10)
    }
}
