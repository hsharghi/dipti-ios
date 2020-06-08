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

    weak var delegate: CateogryTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
        setupColorCollection()
        setupSizeCollection()

        selectAllCategoriesButton.roundConrners(masks: .allCorners, radius: 10)
        self.delegate = categoryTableView
    }

    
    private func setupSlider() {
        slider.valueLabelPosition = .bottom
        slider.isValueLabelRelative = false
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fa_IR")
        formatter.numberStyle = .decimal
        slider.valueLabelFormatter = formatter
        slider.valueLabelFormatter.positiveSuffix = " تومان"
        slider.addTarget(self, action: #selector(sliderChanged(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDragEnded(slider:)), for: . touchUpInside)

    }
    
    private func setupColorCollection() {
        var colors: [UIColor] = []
        for _ in 0..<7 {
            colors.append(UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1))
        }
        colorCollectionView.colors = colors
        colorCollectionView.multiSelect = true
        colorCollectionView.delegate = colorCollectionView
        colorCollectionView.dataSource = colorCollectionView
    }

    private func setupSizeCollection() {
        sizeCollectionView.sizes = ProductOption.clothSizes.compactMap({$0.value})
        sizeCollectionView.multiSelect = true
        sizeCollectionView.delegate = sizeCollectionView
        sizeCollectionView.dataSource = sizeCollectionView
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func sliderChanged(slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }

    @objc func sliderDragEnded(slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }

    @IBAction func selectAllCategories(_ sender: Any) {
        delegate?.selectAllCategories()
    }
    
}
