//
//  SizePickerCollectionView.swift
//  Dipti
//
//  Created by Hadi Sharghi on 3/10/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol SizePickerCollectionViewDelegate: class {
    func selectionChanged(selected: [String])
}

extension SizePickerCollectionView: SizePickerCollectionViewDelegate {
    func selectionChanged(selected: [String]) { }
}


class SizePickerCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var sizes = [String]()
    var selectedIndices: [Int] = [] {
        didSet {
            reloadData()
        }
    }
    var multiSelect: Bool = false
    var pickerDelegate: SizePickerCollectionViewDelegate?
    
    let cellSize = CGSize(width: 60, height: 40)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizePickerCell.cellId, for: indexPath) as! SizePickerCell
        
        cell.selectedCell = selectedIndices.contains(indexPath.item)
        cell.size = sizes[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let totalCellWidth: CGFloat = cellSize.width * CGFloat(sizes.count)
        let totalSpacingWidth: CGFloat = 10 * CGFloat(sizes.count - 1)

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
            selectedIndices = [indexPath.item]
        }
        pickerDelegate?.selectionChanged(selected: sizes.filter { selectedIndices.contains(sizes.firstIndex(of: $0)!) })
    }
    
    
    
}

class SizePickerCell: UICollectionViewCell {
    
    static let cellId = "sizeCell"
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var selectedCell = false
    
    var size: String? {
        didSet {
            if let size = size {
                setupCell(with: size)
            }
        }
    }
    
    private func setupCell(with size: String) {
        contentView.layer.borderColor = AppData.color.darkBlue.cgColor
        colorView.layer.cornerRadius = 17
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = self.selectedCell ? 3 : 0
        colorView.backgroundColor = AppData.color.yellow
        contentView.backgroundColor = UIColor.clear
        colorView.layer.masksToBounds = true;
        sizeLabel.text = size
    }
}


