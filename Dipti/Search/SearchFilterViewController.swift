//
//  SearchFilterViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/6/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import MultiSlider

protocol CateogryTableViewDelegate: class {
    func selectAllCategories()
}

class SearchFilterViewController: UIViewController {
    
    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var categoryTableView: AdvancedSearchCategoryTableView!
    @IBOutlet weak var colorCollectionView: ColorPickerCollectionView!
    @IBOutlet weak var sizeCollectionView: SizePickerCollectionView!
    @IBOutlet weak var selectAllCategoriesButton: UIButton!
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    
    weak var delegate: CateogryTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        colorCollectionView.pickerDelegate = self
        sizeCollectionView.pickerDelegate = self
        categoryTableView.tableViewDelegate = self
        
        selectAllCategoriesButton.roundConrners(masks: .allCorners, radius: 10)
        self.delegate = categoryTableView
    }
    
    private func setupView() {
        
        [100, 101].forEach({view.viewWithTag($0)?.roundConrners(masks: .allCorners, radius: 10)})
        setupSlider()
        setupColorCollection()
        setupSizeCollection()
        setupTableView()
    }
    
    @IBAction private func clearFilters() {
        AppData.filter.clear()
        setupView()
    }
    
    @IBAction private func assignFilters() {
        dismiss(animated: true)
    }
    
    private func setupTableView() {
        categoryTableView.selectedCategories = AppData.filter.categories
    }
    
    private func setupSlider() {
        slider.value = [AppData.filter.minPrice == 0 ? 10_000 : CGFloat(AppData.filter.minPrice), AppData.filter.maxPrice == 0 ? 10_000_000 : CGFloat(AppData.filter.maxPrice)]
        slider.valueLabelPosition = .bottom
        slider.isValueLabelRelative = false
        slider.outerTrackColor = AppData.color.gray
        slider.tintColor = AppData.color.yellow
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fa_IR")
        formatter.numberStyle = .decimal
        slider.valueLabelFormatter = formatter
        slider.valueLabelFormatter.positiveSuffix = " تومان"
        slider.addTarget(self, action: #selector(sliderChanged(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDragEnded(slider:)), for: . touchUpInside)
        minPriceLabel.text = AppData.filter.minPrice.wordifyFa
        maxPriceLabel.text = AppData.filter.maxPrice.wordifyFa
        slider.valueLabels.forEach({$0.font = UIFont(name: "IRANSansWeb", size: 12)})

    }
    
    private func setupColorCollection() {
        
        colorCollectionView.colors = Product.allColors
        colorCollectionView.multiSelect = true
        colorCollectionView.selectedIndices = filteredIndices(items: Product.allColors, filterItems: AppData.filter.colors)
        colorCollectionView.delegate = colorCollectionView
        colorCollectionView.dataSource = colorCollectionView
    }
    
    private func setupSizeCollection() {
        sizeCollectionView.sizes = ProductOption.clothSizes.compactMap({$0.value})
        sizeCollectionView.selectedIndices = filteredIndices(items: sizeCollectionView.sizes, filterItems: AppData.filter.clothSizes)
        sizeCollectionView.multiSelect = true
        sizeCollectionView.delegate = sizeCollectionView
        sizeCollectionView.dataSource = sizeCollectionView
    }

    private func filteredIndices<T: Equatable>(items: [T], filterItems: [T]) -> [Int] {
         guard !filterItems.isEmpty else { return [] }
         var indices = [Int]()
         for item in filterItems {
             if filterItems.contains(item) {
                 indices.append(items.firstIndex(of: item)!)
             }
         }
         return indices
     }

    @objc func sliderChanged(slider: MultiSlider) {
        if slider.draggedThumbIndex == 0 {
            minPriceLabel.text = Int(slider.value[0]).wordifyFa
        } else {
            maxPriceLabel.text = Int(slider.value[1]).wordifyFa
        }
    }

    @objc func sliderDragEnded(slider: MultiSlider) {
        if slider.draggedThumbIndex == 0 {
            AppData.filter.setPriceFilter(min: slider.value[0])
            minPriceLabel.text = Int(slider.value[0]).wordifyFa
        } else {
            AppData.filter.setPriceFilter(max: slider.value[1])
            maxPriceLabel.text = Int(slider.value[1]).wordifyFa
        }
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }

    @IBAction func selectAllCategories(_ sender: Any) {
        delegate?.selectAllCategories()
    }
    
}

extension SearchFilterViewController: CategoryTableViewDelegate {
    func selectionChanged(selected: [Category]) {
        AppData.filter.setCategory(categories: selected)
    }
}

extension SearchFilterViewController: SizePickerCollectionViewDelegate {
    func selectionChanged(selected: [String]) {
        AppData.filter.setClothSize(sizes: selected)
    }
}

extension SearchFilterViewController: ColorPickerCollectionViewDelegate {
    func selectionChanged(selected: [UIColor]) {
        AppData.filter.setColor(colors: selected)
    }
}
