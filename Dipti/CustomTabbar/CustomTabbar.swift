//
//  CustomTabbar.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/20/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol CustomTabbarDelegate: class {
    func didSelectTabItem(index: Int)
}

class CustomTabbar: UIViewController {
    
    @IBOutlet var tabbarButtons: [UIButton]!
    @IBOutlet weak var highlighterView: UIView!
    
    weak var delegate: CustomTabbarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHighlighter()
        tabbarButtonTapped(tabbarButtons.first as Any)
    }
    
    func setupHighlighter() {
        highlighterView.backgroundColor = AppData.color.yellow
        highlighterView.isUserInteractionEnabled = false
    }
    
    @IBAction func tabbarButtonTapped(_ sender: Any) {
        
        let button = sender as! UIButton
        let index = button.tag
        print("button \(index) tapped")
        
        delegate?.didSelectTabItem(index: index)
        highlightButton(for: index)
        
    }
    
    private func highlightButton(for index: Int) {
        highlighterView.isHidden = false
        if let selectedButton = tabbarButtons.filter({$0.tag == index}).first {
            highlighterView.frame = selectedButton.frame
        }
    }
    
}
