//
//  LoginViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class RegisterViewController: FormViewController {
    
    @IBOutlet weak var name: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView(scrollView, contentView: contentView)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard validateFields() else { return }
        
        flashLoading(for: 1.5) {
            AppHelper.showAlert("ثبت نام", message: "ثبت نام شما در سایت دیپ‌تی با موفقیت انجام شد.", dismissButtonTitle: "باشه")
            AppData.loginToken = "token"
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func validateFields() -> Bool {
        var validation = true
        
        if (name.text ?? "").isEmpty {
            name.errorMessage = "نام خود را وارد کنید"
            validation = false
        }
        
        if let phoneNumber = phoneNumber.text, !phoneNumber.isEmpty, phoneNumber.digits != phoneNumber {
            self.phoneNumber.errorMessage = "شماره موبایل نامعتبر است"
            validation = false
        }
        
        if (email.text ?? "").isEmpty {
            email.errorMessage = "آدرس ایمیل معتبر نیست"
            validation = false
        }
        
        if let password = password.text {
            if password.isEmpty || password.count < 6 {
                self.password.errorMessage = "رمز عبور باید حداقل ۶ کاراکتر باشد"
                validation = false
            }
        }
        
        if let password = password.text, let confirm = confirmPassword.text {
            if password != confirm {
                confirmPassword.errorMessage = "تکرار رمز عبور با رمز عبور وارد شده یکسان نیست"
                validation = false
            }
        }
        return validation
    }
    
}
