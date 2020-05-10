//
//  LoginViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftyHUDView


class LoginViewController: FormViewController {
    
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.transparent(animated: true)
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard validateFields() else { return }
        
        flashLoading(for: 1.0) {
            AppData.loginToken = "token"
            self.dismiss(animated: true)
        }
        
        
    }
    
    @IBAction func signupTapped(_ sender: Any) {
    
    }
    
    private func validateFields() -> Bool {
        var validation = true
        if (email.text ?? "").isEmpty {
            email.errorMessage = "آدرس ایمیل معتبر نیست"
            validation = false
        }
        if (password.text ?? "").isEmpty {
            password.errorMessage = "پسورد را وارد کنید"
            validation = false
        }
        
        return validation
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.opaque(animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = "بازگشت"
        navigationItem.backBarButtonItem = backItem
    }

}
