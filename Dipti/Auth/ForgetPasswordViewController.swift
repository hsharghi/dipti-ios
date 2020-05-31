//
//  LoginViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class ForgetPasswordViewController: FormViewController {
    
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func retrievePasswordTapped(_ sender: Any) {
        guard validateFields() else { return }

        flashLoading(for: 1.5) {
            self.resultLabel.text = AppData.forgetPasswordResponse
            self.resultLabel.isHidden = false
            (self.view.subviews.filter {$0 is UIButton}.first as! UIButton).isEnabled = false
            self.view.endEditing(true)
        }
    }
    
    private func validateFields() -> Bool {
        var validation = true
        if (email.text ?? "").isEmpty {
            email.errorMessage = "آدرس ایمیل معتبر نیست"
            validation = false
        }
        
        return validation
    }
    
}
