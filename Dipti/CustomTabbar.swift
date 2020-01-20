//
//  CustomTabbar.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/20/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

class CustomTabbar: UIViewController {
    
    @IBOutlet var tabbarButtons: [UIButton]!
    let highlighterView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHighlighter()
        
    }
    
    func setupHighlighter() {
        highlighterView.backgroundColor = AppData.color.yellow
        highlighterView.isUserInteractionEnabled = false
        self.view.addSubview(highlighterView)
        highlighterView.layer.zPosition = 0

    }
    
    @IBAction func tabbarButtonTapped(_ sender: Any) {
        
        let button = sender as! UIButton
        let index = button.tag
        print("button \(index) tapped")
        highlightButton(for: index)
        
        
    }
    
    private func highlightButton(for index: Int) {
        
        if let selectedButton = tabbarButtons.filter({$0.tag == index}).first {
            highlighterView.frame = selectedButton.frame
        }
    }
    
}
