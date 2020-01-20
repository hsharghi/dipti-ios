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
    
    
    
    @IBAction func tabbarButtonTapped(_ sender: Any) {
        
        let button = sender as! UIButton
        let index = button.tag
        print("button \(index) tapped")
        
        
        
    }
    
    private func highlightButton(for index: Int) {
        
        for button in tabbarButtons {
            button.alpha = button.tag == index ? 1 : 0
        }
        
    }
    
}
