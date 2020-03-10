//
//  ColorPickerCollectionView.swift
//  Dipti
//
//  Created by Hadi Sharghi on 3/10/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class ColorPickerCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var colors = [UIColor]()
    var selectedIndex = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickerCell.cellId, for: indexPath) as! ColorPickerCell
        
        cell.selectedCell = (indexPath.item == selectedIndex) ? true : false
        cell.color = colors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        reloadData()
    }
    
    
    
}

class ColorPickerCell: UICollectionViewCell {
    
    static let cellId = "colorCell"
    @IBOutlet weak var colorView: UIView!
    var selectedCell = false
    
    var color: UIColor? {
        didSet {
            if let color = color {
                setupCell(with: color)
            }
        }
    }
    
    private func setupCell(with color: UIColor) {
        contentView.layer.borderColor = AppData.color.yellow.cgColor
        colorView.layer.cornerRadius = 17
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = self.selectedCell ? 3 : 0
        colorView.backgroundColor = color
        contentView.backgroundColor = UIColor.clear
        colorView.layer.masksToBounds = true;
    }
}


