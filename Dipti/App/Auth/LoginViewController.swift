//
//  LoginViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/26/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class LoginViewController: FormViewController {
    
    @IBOutlet weak var email: TitleBarTextField!
    @IBOutlet weak var password: TitleBarTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView(scrollView, contentView: contentView)
        view.viewWithTag(99)?.roundConrners(masks: .allCorners, radius: 8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.transparent(animated: true)
        setupSocialButtons()
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard validateFields() else { return }
        
        flashLoading(for: 1.0) {
            if let customer = CustomerRepository.login(email: self.email.text!) {
                AppData.loginToken = "token"
                AppData.customer = customer
                self.dismiss(animated: true)
            }
            
            self.email.errorMessage = "نام کاربری اشتباه است"
            return
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
    
    private func setupSocialButtons() {
        if let googleButton = view.viewWithTag(100) as? UIButton {
            googleButton.setBackgroundImage(UIImage(named: "login-google"), for: .normal)
            googleButton.layoutIfNeeded()
            googleButton.backgroundColor = UIColor(hexString: "DC4E41")
            googleButton.subviews.first?.contentMode = .scaleAspectFit
            googleButton.roundConrners(masks: .leftCorners, radius: 10)
        }
        if let facebookButton = view.viewWithTag(200) as? UIButton {
            facebookButton.setBackgroundImage(UIImage(named: "login-facebook"), for: .normal)
            facebookButton.layoutIfNeeded()
            facebookButton.backgroundColor = UIColor(hexString: "3B5998")
            facebookButton.subviews.first?.contentMode = .scaleAspectFit
            facebookButton.roundConrners(masks: .rightCorners, radius: 10)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationController?.opaque(animated: true)
        let backItem = UIBarButtonItem()
        backItem.title = "بازگشت"
        navigationItem.backBarButtonItem = backItem
    }

}
