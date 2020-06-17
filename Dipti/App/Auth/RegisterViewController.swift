//
//  LoginViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


class RegisterViewController: FormViewController {
    
    @IBOutlet weak var firstName: TitleBarTextField!
    @IBOutlet weak var lastName: TitleBarTextField!
    @IBOutlet weak var email: TitleBarTextField!
    @IBOutlet weak var phoneNumber: TitleBarTextField!
    @IBOutlet weak var password: TitleBarTextField!
    @IBOutlet weak var gender: UISegmentedControl!
    //    @IBOutlet weak var confirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView(scrollView, contentView: contentView)
        view.viewWithTag(99)?.roundConrners(masks: .allCorners, radius: 8)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard validateFields() else { return }
        
        flashLoading(for: 1.5) {
            AppHelper.showAlert("ثبت نام", message: "ثبت نام شما در سایت دیپ‌تی با موفقیت انجام شد.", dismissButtonTitle: "باشه") {
                self.dismiss(animated: true, completion: nil)
            }
            AppData.loginToken = "token"
            AppData.customer = CustomerRepository.register(email: self.email.text!, firstName: self.firstName.text!, lastName: self.lastName.text!, gender: self.gender.selectedSegmentIndex == 0 ? "f" : "m")
        }
    }
    
    private func validateFields() -> Bool {
        var validation = true
        
        if (firstName.text ?? "").isEmpty {
            firstName.errorMessage = "نام خود را وارد کنید"
            validation = false
        }
        
        if (lastName.text ?? "").isEmpty {
            lastName.errorMessage = "نام خانوادگی خود را وارد کنید"
            validation = false
        }
        
        if let phoneNumber = phoneNumber.text, !phoneNumber.isEmpty, phoneNumber.digits != phoneNumber {
            self.phoneNumber.errorMessage = "شماره تلفن همراه نامعتبر است"
            validation = false
        }
        
        if (email.text ?? "").isEmpty {
            email.errorMessage = "پست الکترونیک معتبر نیست"
            validation = false
        }
        
        if AppData.registeredCustomers.filter({$0.email == email.text!}).first != nil {
            email.errorMessage = "این ایمیل قبلا در سایت ثبت شده است."
            validation = false
        }
        
        if let password = password.text {
            if password.isEmpty || password.count < 6 {
                self.password.errorMessage = "رمز عبور باید حداقل ۶ کاراکتر باشد"
                validation = false
            }
        }
        
//        if let password = password.text, let confirm = confirmPassword.text {
//            if password != confirm {
//                confirmPassword.errorMessage = "تکرار رمز عبور با رمز عبور وارد شده یکسان نیست"
//                validation = false
//            }
//        }
        return validation
    }
    
}
