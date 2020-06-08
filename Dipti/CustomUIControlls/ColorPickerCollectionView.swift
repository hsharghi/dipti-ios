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
    var selectedIndices: [Int] = []
    var multiSelect: Bool = false
    
    let cellSize = CGSize(width: 40, height: 40)


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorPickerCell.cellId, for: indexPath) as! ColorPickerCell
        
        cell.selectedCell = selectedIndices.contains(indexPath.item) ? true : false
        cell.color = colors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth: CGFloat = cellSize.width * CGFloat(colors.count)
        let totalSpacingWidth: CGFloat = 10 * CGFloat(colors.count - 1)

        let leftInset = (self.bounds.width - (totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if multiSelect {
            if selectedIndices.contains(indexPath.item) {
                selectedIndices.remove(object: indexPath.item)
            } else {
                selectedIndices.append(indexPath.item)
            }
        } else {
            selectedIndices.removeAll()
            selectedIndices.append(indexPath.item)
        }
        
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


