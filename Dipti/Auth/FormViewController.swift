//
//  FormViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 5/10/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class FormViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        setupView()
        self.view.subviews.forEach { (view) in
            if let textField = view as? SkyFloatingLabelTextField {
                textField.delegate = self
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? SkyFloatingLabelTextField {
            textField.errorMessage = nil
        }
    }
    
    private func setupView() {
        
        // round corner buttons
        self.view.subviews.forEach { (view) in
            if let button = view as? UIButton {
                button.roundConrners(masks: .allCorners, radius: 16)
            }
            if let textBox = view as? SkyFloatingLabelTextField {
                textBox.textAlignment = .center
                textBox.titleLabel.textAlignment = .center
            }
        }

    }

}

