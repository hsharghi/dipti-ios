//
//  AdvancedSearchCategoryTableView.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/31/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol CategoryTableViewDelegate {
    func selectionChanged(selected: [Category])
}

extension AdvancedSearchCategoryTableView: CategoryTableViewDelegate {
    func selectionChanged(selected: [Category]) { }
}

class AdvancedSearchCategoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    
    var categories: [Category] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var selectedCategories: [Category] = [] {
        didSet {
            reloadData()
        }
    }
    var countOfCategories: [Int] = []
    var tableViewDelegate: CategoryTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        categories = Category.categories
        categories.forEach({_ in countOfCategories.append(Int.random(in: 10...100))})
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.dequeueReusableCell(withIdentifier: AdvancedSearchCategoryTableViewCell.cellID, for: indexPath) as? AdvancedSearchCategoryTableViewCell {
            cell.category = categories[indexPath.row]
            cell.delegate = self
            cell.isSeletedCategory = selectedCategories.contains(categories[indexPath.row])
            cell.count.text = "(\(countOfCategories[indexPath.row]))".toFa()
            cell.selectionStyle = .none
            return cell
        }
        
        fatalError("No cell for category")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension AdvancedSearchCategoryTableView: CategoryCellDelegate {
    func selectionChanged(on cell: AdvancedSearchCategoryTableViewCell) {
        if let indexPath = self.indexPath(for: cell) {
            if selectedCategories.contains(categories[indexPath.row]) {
                selectedCategories.remove(object: categories[indexPath.row])
            } else {
                selectedCategories.append(categories[indexPath.row])
            }
            tableViewDelegate?.selectionChanged(selected: selectedCategories)
        }
    }
}

extension AdvancedSearchCategoryTableView: CateogryTableViewDelegate {
    func selectAllCategories() {
        selectedCategories.removeAll()
        selectedCategories.append(contentsOf: categories)
    }
}

protocol CategoryCellDelegate: class {
    func selectionChanged(on cell: AdvancedSearchCategoryTableViewCell)
}

class AdvancedSearchCategoryTableViewCell: UITableViewCell {
    
    static let cellID = "categoryCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    weak var delegate: CategoryCellDelegate?
    var isSeletedCategory = false {
        didSet {
            selectButton.isSelected = isSeletedCategory
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .clear
        bgView.roundConrners(masks: .allCorners, radius: 14)
        selectButton.roundConrners(masks: .allCorners, radius: 4)
        selectButton.setImage(UIImage(named: "check-button"), for: .selected)
    }
    
    
    var category: Category? {
        didSet {
            name.text = category!.name + " - " + (category!.parent?.name ?? "")
        }
    }
    
    @IBAction func selectionButtonTapped(_ sender: Any) {
        delegate?.selectionChanged(on: self)
    }
}
